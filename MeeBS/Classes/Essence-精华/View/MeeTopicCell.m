//
//  MeeTopicCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MeeTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *hreadImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;  // 文本内容



// 最热评论
@property (weak, nonatomic) IBOutlet UILabel *hotCommetLabel; // 最热评论内容

@property (weak, nonatomic) IBOutlet UIView *cmtToolView;


@end


@implementation MeeTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTopicModel:(MeeTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    // 设置头像(圆角头像)
    [self.hreadImageView setHeaderImage:self.topicModel.profile_image];
    
    // 设置昵称
    self.nameLabel.text = self.topicModel.name;
    
    // 设置时间
    self.timeLabel.text = self.topicModel.created_at;
    
    // 设置文本内容
    self.contentLabel.text = self.topicModel.text;
    
    // 最热评论的内容 (用户名 + 评论内容组成)
    // 方式一： 直接使用最热评论的 NSArray 数组（不使用数据模型）
    if(topicModel.top_cmt.count){  // 不为0 ，说明有最热评论
        // 在cell防止重用，if else 都要进行 hidden设置
        
        self.cmtToolView.hidden = NO;
        // 获取最热评论的内容
        NSDictionary *cmtDic = topicModel.top_cmt[0];
        
        // 获取用户名
        NSString *userName = cmtDic[@"user"][@"username"];
        
        // 评论的内容
        NSString *cmtText = cmtDic[@"content"];
        
        self.hotCommetLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,cmtText];
        
    }else{
        self.cmtToolView.hidden = YES;
    }
     
}

// 重写setFrame
// 当封装一些控件时，不想外界改变控件的大小，可以在这个位置，直接设置固定尺寸。因为外界改变尺寸，最终会来到这个方法，被拦截了，进行重写设置
// 重写setFrame方法：拦截cell对frame设置
// 只要cell的尺寸和位置改变，都会调用这个方法进行设置
// 重写这个方法可以设置：cell与屏幕两端的距离
// 可以再调用父类之前修改高度，设置cell之间的分割线
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
   
}


@end
