//
//  ChatCell.h
//  parse-chat
//
//  Created by Miguel Arriaga Velasco on 6/27/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatText;
@property (strong, nonatomic) PFObject *chat;

- (void)setChat:(PFObject *)chat;

@end

NS_ASSUME_NONNULL_END
