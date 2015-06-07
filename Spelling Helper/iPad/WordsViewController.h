//
//  WordsViewController.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/4/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordList.h"
#import "Word.h"
#import <AVFoundation/AVFoundation.h>
#import "FliteTTS.h"

@interface WordsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, AVAudioRecorderDelegate> {
    WordList *wordList;
    UITableView *wordTable;
    NSMutableArray *words;
    NSManagedObjectContext *managedObjectContext;
    UILabel *listLabel;
    UIImageView *backgroundImage;
    UILabel *recordWordInstructions;
    UIView *addWordView;
    
    UIButton *recordWordButton;
    UIButton *addWordButton;
    UIButton *playWordButton;
    
    // sound stuff
    NSURL *soundFileURL;
    AVAudioRecorder *soundRecorder;
    BOOL recording;
    FliteTTS *flite;
}

@property (nonatomic, retain) WordList *wordList;
@property (nonatomic, retain) NSMutableArray *words;

@property (nonatomic, retain) IBOutlet UITextField *wordEdit;
@property (nonatomic, retain) IBOutlet UITableView *wordTable;
@property (nonatomic, retain) IBOutlet UILabel *listLabel;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIButton *recordWordButton;
@property (nonatomic, retain) IBOutlet UIButton *addWordButton;
@property (nonatomic, retain) IBOutlet UIButton *playWordButton;

@property (nonatomic, retain) IBOutlet UILabel *recordWordInstructions;
@property (nonatomic, retain) IBOutlet UIView *addWordView;

//sound stuff
@property (nonatomic, retain) NSURL *soundFileURL;
@property (nonatomic, retain) AVAudioRecorder *soundRecorder;

-(IBAction) addWordClick: (id) sender;
-(IBAction) startRecordingClick: (id) sender;
-(IBAction) playWordClick: (id) sender;

@end
