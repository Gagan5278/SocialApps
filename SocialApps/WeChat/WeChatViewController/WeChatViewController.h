//
//  WeChatViewController.h
//  SocialApps
//
//  Created by Gagan Mishra on 10/16/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendTextContent;
- (void) sendImageContent;
- (void) sendLinkContent;
- (void) sendMusicContent;
- (void) sendVideoContent;
- (void) sendAppContent;
- (void) sendNonGifContent;
- (void) sendGifContent;
- (void) sendAuthRequest;
- (void) sendFileContent;
@end

@interface WeChatViewController : UIViewController{
    UIButton *sendNonGIFBtn;
    UIButton *sendGIFBtn;
    
    UIButton *oAuthBtn;
    UIButton *sendFileBtn;
}

@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate,NSObject> delegate;
@end
