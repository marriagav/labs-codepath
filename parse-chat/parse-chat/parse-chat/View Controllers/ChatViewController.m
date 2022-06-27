//
//  ChatViewController.m
//  parse-chat
//
//  Created by Miguel Arriaga Velasco on 6/27/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textMessage;
@property (weak, nonatomic) NSMutableArray *chatsArray;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
}

- (IBAction)sendTextMessage:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    chatMessage[@"text"]=self.textMessage.text;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (succeeded) {
                NSLog(@"The message was saved!");
                self.textMessage.text=@"";
            } else {
                NSLog(@"Problem saving message: %@", error.localizedDescription);
            }
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section{
//    return amount of chats in the chatsArray
        return self.chatsArray.count;
}

- (void)onTimer {
//    What to do every 1 sec
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *texts, NSError *error) {
        if (texts != nil) {
//            NSLog(@"%@", texts);
            self.chatsArray = (NSMutableArray *)texts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath{
//    initialize cell (ChatCell) to a reusable cell using the ChatCell identifier
    ChatCell *cell = [tableView
    dequeueReusableCellWithIdentifier: @"ChatCell"];
    NSDictionary *object = self.chatsArray[indexPath.row];
//    cell.chat = object;
    cell.chatText.text = object[@"text"];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
