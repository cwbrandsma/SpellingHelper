//
//  WordsViewController.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/4/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "WordsViewController.h"
#import "Word.h"
#import "Spelling_HelperAppDelegate.h"
#import <CoreAudio/CoreAudioTypes.h>
#import "Constants.h"
#import "FliteTTS.h"
#import "UIView+DefaultShadow.h"
#import "UIButton+Red.h"
#import "UIViewController+Rotate.h"

@interface WordsViewController()
-(NSData *) soundToNSData;
-(void) playWord: (Word *) word;
-(IBAction) clearRecording;
    
@end

@implementation WordsViewController
@synthesize wordList, words, wordTable, wordEdit, listLabel, backgroundImage, recordWordButton, recordWordInstructions, addWordView, addWordButton, playWordButton;

// sound stuff
@synthesize soundFileURL, soundRecorder;


-(void) loadManagedObjectContext {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 
    
    managedObjectContext = mainMOC;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [wordTable release];
    [wordList release];
    [words release];
    [backgroundImage release];
    [recordWordButton release];
    [recordWordInstructions release];
    [addWordView release];
    [playWordButton release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) loadNavigtionBar{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"+" 
                                  style:UIBarButtonItemStyleBordered 
                                  target:self 
                                  action:@selector(addWordClick:)];
	
	self.navigationItem.leftBarButtonItem = addButton;
	[addButton release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listLabel.text = wordList.Name;
    NSLog(@"%@",wordList.Name);
    [self loadManagedObjectContext];
    self.words = [NSMutableArray arrayWithArray: [self.wordList.Words allObjects]];
    
    self.wordTable.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Canvas.400.jpg"]];
    [self.wordTable.backgroundView drawDefaultShadow];
    [self.wordTable reloadData];
    
    [recordWordButton styleButton:[UIColor whiteColor]];
    [playWordButton styleButton:[UIColor whiteColor]];
    [addWordButton styleButton:[UIColor redColor]];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.wordTable.frame.size.width, 60);
    CALayer *blueLine = [[CALayer alloc] init];
    blueLine.backgroundColor = [UIColor redColor].CGColor;
    blueLine.opacity = 0.5;
    blueLine.frame =  CGRectMake(0, headerView.frame.size.height-2, headerView.frame.size.width, 2);
    
    [headerView.layer addSublayer:blueLine];
    [blueLine release];
    
    UILabel *headerTitle = [[UILabel alloc] init];
    headerTitle.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    headerTitle.text = wordList.Name;
    headerTitle.font = [UIFont fontWithName:@"Marker Felt"  size:30.0];
    headerTitle.backgroundColor = [UIColor clearColor];
    headerTitle.textAlignment = UITextAlignmentCenter;

    [headerView addSubview:headerTitle];
    [headerTitle release];
    
    self.wordTable.tableHeaderView = headerView;
}

- (void)viewDidUnload
{
    [flite release];
    [wordTable release];
    [wordEdit release];
    [listLabel release];
    [backgroundImage release];
    [words release];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillDisappear:(BOOL)animated {
    
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate saveContext];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration {
    [self handlerRotate:toInterfaceOrientation :backgroundImage];
}



#pragma mark -
#pragma mark Action Handlers
-(IBAction) addWordClick: (id) sender {
    NSLog(@"%@",wordEdit.text);
    
    NSString *entityName = @"Word";
    Word *wl = [NSEntityDescription insertNewObjectForEntityForName:entityName 
                                                 inManagedObjectContext:managedObjectContext];
    
    wl.Word = wordEdit.text;
    wl.Sound = [self soundToNSData];
    
    [wordList addWordsObject:wl];
    [self.words addObject:wl];
    
    [managedObjectContext save:nil];
    
    [self.wordTable reloadData];
    
    wordEdit.text = @"";
    [self clearRecording];
    recordWordInstructions.hidden = YES;
}

#pragma mark - 
#pragma mark Table View Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
	Word *cat = [self.words objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = UITextAlignmentCenter;

        UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        backgroundView.backgroundColor  = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        cell.selectedBackgroundView = backgroundView;
        [backgroundView release];
        
        CALayer *blueLine = [[CALayer alloc] init];
        blueLine.backgroundColor = [UIColor blueColor].CGColor;
        blueLine.opacity = 0.5;
        blueLine.frame =  CGRectMake(0, cell.frame.size.height-2, tableView.frame.size.width, 1);

        [cell.contentView.layer addSublayer:blueLine];
        [blueLine release];
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"%d:\t %@", indexPath.row+1, cat.Word];
	
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Word *aWord = [self.words objectAtIndex:indexPath.row];
    
    [self playWord: aWord];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView1 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];

    /*
    NSArray *removeIndexes = [NSArray arrayWithObject:indexPath];
    [tableView1 deleteRowsAtIndexPaths:removeIndexes
                          withRowAnimation:UITableViewRowAnimationFade];
*/
    Word *w = [words objectAtIndex:row];
    [managedObjectContext deleteObject:w];
    [words removeObjectAtIndex:row];
    [tableView1 reloadData];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Unsubscribe";
} */



- (NSString *)applicationDocumentsDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *) createFileName: (NSString *) name  {
	NSString *documentsDirectory = [self applicationDocumentsDirectory];
	
	NSString *fullFileName = [documentsDirectory stringByAppendingPathComponent:name];
	return fullFileName;
}

-(NSData*) soundToNSData {
    NSString *soundFilePath = [self createFileName: @"tempaudio.aiff"]; 
    NSData *myData = [NSData dataWithContentsOfFile:soundFilePath];  
    return myData;    
}

-(void) showPlayRecordingMessage {
    recordWordInstructions.text = @"Tap Play Word to hear the recording.";
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"]; 
    theAnimation.duration=6.0; 
    theAnimation.repeatCount=0; 
    theAnimation.autoreverses=NO;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0]; 
    theAnimation.toValue=[NSNumber numberWithFloat:0.0]; 
    [[recordWordInstructions layer] addAnimation:theAnimation forKey:@"animateOpacity"];
}

-(void) showStartMicMessage {
    recordWordInstructions.hidden = NO;
    //TODO: need a way display this message before this method continues
    recordWordInstructions.text = @"Starting Microphone";
    recordWordInstructions.layer.opacity = 1.0;
    
}

-(void) startRecording {
    // Setup URL
    // You will be setting up the path where you will be saving your audio file, in my case i saved it to my app doc folder
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    
    
    NSString *soundFilePath = [self createFileName: @"tempaudio.aiff"]; 
    // getFilename is my own method
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    self.soundFileURL = newURL;
    
    [newURL release];
    
    // Setup recording settings
    NSDictionary *recordSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0],               AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatAppleIMA4],   AVFormatIDKey,
     [NSNumber numberWithInt: 1],                       AVNumberOfChannelsKey,
     [NSNumber numberWithInt: AVAudioQualityMedium],    AVEncoderAudioQualityKey,
     nil];
    
    // Setup Recorder
    printf("Sound File URL: %s\n", [soundFileURL.path UTF8String]);
    AVAudioRecorder *newRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:nil];
    [recordSettings release];
    self.soundRecorder = newRecorder;
    [newRecorder release];
    soundRecorder.delegate = self;
    printf("%s\n", [soundRecorder prepareToRecord] ? "Recorder Prepared" : "Recorder FAILED");
    
    BOOL audioHWAvailable = audioSession.inputIsAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        [cantRecordAlert release]; 
        return;
    }
    
    [soundRecorder record];
    
    recordWordInstructions.hidden = NO;
    recordWordInstructions.text = @"Speak into microphone";

    [recordWordButton setTitle:@"Stop Recording" forState:UIControlStateNormal];
    
    recording = YES;
}

-(void) stopRecording {
    [soundRecorder stop];
    recording = NO;
    
    [recordWordButton setTitle:@"Record Word" forState:UIControlStateNormal];
}


-(IBAction) startRecordingClick:(id)sender {
    if (recording) {
        [self stopRecording];
        [self showPlayRecordingMessage];
    }
    else {
        [self showStartMicMessage];
        [self startRecording];
    }
}

-(IBAction) clearRecording{
    NSString *soundFilePath = [self createFileName: @"tempaudio.aiff"]; 
    [[NSFileManager defaultManager] removeItemAtPath:soundFilePath error:nil];
}

-(IBAction) playWordClick:(id)sender {
    NSString *soundFilePath = [self createFileName: @"tempaudio.aiff"]; 
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:newURL error:nil];
    [player prepareToPlay];
    [player play];
}

-(void) playWord: (Word*) word {
    if (word.Sound == nil) {
        if (flite == nil) {
            flite = [[[FliteTTS alloc] init] retain];
        }
        [flite speakText:word.Word];
    }
    else {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:word.Sound error:nil];
        [player prepareToPlay];
        [player play];
    }
}

@end
