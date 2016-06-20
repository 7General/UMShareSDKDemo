//
//  MainViewController.m
//  ShareInfo
//
//  Created by 王会洲 on 16/4/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height


#import "MainViewController.h"
#import "UMSocial.h"

@interface MainViewController ()<UMSocialUIDelegate>
/**
 *  用户头像
 */
@property (nonatomic, strong) UIImageView * iconImageView;


@property (nonatomic, strong) UMSocialControllerService * SocialController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 6p w : 414 h : 736
    // 6 w: 375 h : 667
    // 5 w: 320 h : 568
    NSLog(@"---宽度--%f",KSCREENWIDTH);
    NSLog(@"---高度--%f",KSCREENHEIGHT);
    
    
    self.view.backgroundColor = YSColor(246, 246, 246);
    
    UIButton * ShareBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    ShareBtn.frame = CGRectMake(100, 100, 50, 50);
    [ShareBtn setImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
    [ShareBtn addTarget:self action:@selector(ShareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ShareBtn];
    
    
    
    
    UIButton * QQLogin  = [UIButton buttonWithType:UIButtonTypeCustom];
    QQLogin.frame = CGRectMake(50, 400, 50, 50);
    [QQLogin setImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
    [QQLogin addTarget:self action:@selector(QQLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQLogin];
    
    UIButton * weChat  = [UIButton buttonWithType:UIButtonTypeCustom];
    weChat.frame = CGRectMake(200, 400, 50, 50);
    [weChat setImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
    [weChat addTarget:self action:@selector(weChatClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChat];
    
    
    
    UIButton * WB  = [UIButton buttonWithType:UIButtonTypeCustom];
    WB.frame = CGRectMake(200, 500, 50, 50);
    [WB setImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
    [WB addTarget:self action:@selector(WBClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WB];
    
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT - 100, KSCREENWIDTH, 100)];
    [self.view addSubview:self.iconImageView];
    
    
}

/**
 *  第三方分享
 */
-(void)ShareBtnClick {
    // 设置分享到QQ好友的链接地址
    //[UMSocialData defaultData].extConfig.qqData.url = @"https://github.com/7General";
    //  设置分享到QQ空间的链接地址
    //[UMSocialData defaultData].extConfig.qzoneData.url = @"http://blog.csdn.net/whuizhou/article/details/51245333";
    
    
    //[UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.baidu.com";
    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57186d9e67e58e3606002234"
//                                      shareText:@"分享平台发送内容"
//                                     shareImage:[UIImage imageNamed:@"qq_login"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToEmail,nil]
//                                       delegate:self];
    
    
    
    // 发送图片
    //[[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
    
    // 发送mp3
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeMusic url:@"http://mr4.douban.com/201401091529/6e0b23f37fa584f2a6e58ac70d03b31e/view/song/small/p759182.mp3"];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57186d9e67e58e3606002234"
                                      shareText:@"分享平台发送内容"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToEmail,nil]
                                       delegate:self];


}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData {
    if ([platformName isEqualToString:UMShareToWechatSession]) {
        NSLog(@"这个是微信");
        
    }else if ([platformName isEqualToString:UMShareToWechatTimeline])
    {
        socialData.shareText = @"分享到微信朋友圈>>>>>>>>>>>";
        NSLog(@"这个是微信朋友圈");
    }else if ([platformName isEqualToString:UMShareToQzone])
    {
        socialData.extConfig.qzoneData.shareText = @"分享到QQ空间.........的内容啊";
        NSLog(@"这个是QQ空间");
        
    }else if ([platformName isEqualToString:UMShareToQQ])
    {
        socialData.shareText = @"分享到QQ好友的内容啊";
        
        NSLog(@"这个是QQ好友");
    }else
    {
        socialData.shareText = @"---------mmmmmm---";
        NSLog(@"其他:%@",platformName);
    }

}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

/**
 *  QQ登陆
 */
-(void)QQLoginClick {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"用户昵称>> %@, 用户UID:>> %@, TOKEN:>> %@ 用户头像：>> %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        }});
}

/**
 *  微信登陆
 */
-(void)weChatClick {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"微信username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }
        
    });

}
-(void)WBClick{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
        }});
    
}


@end
