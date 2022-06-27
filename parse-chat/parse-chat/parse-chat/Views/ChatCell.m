//
//  ChatCell.m
//  parse-chat
//
//  Created by Miguel Arriaga Velasco on 6/27/22.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)setChat:(PFObject *)chat {
    _chat = chat;
};

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
