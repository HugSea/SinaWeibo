//
//  QJComposeViewController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/1.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJComposeViewController.h"
#import "QJTextView.h"
#import "QJComposeToolBar.h"
#import "QJComposePhotoView.h"
#import "MBProgressHUD+MJ.h"
#import "QJAccountTool.h"
#import "QJAccount.h"
#import "QJHttpTool.h"
#import "QJStatusTool.h"

@interface QJComposeViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) QJTextView *textView;
@property (nonatomic, weak) QJComposeToolBar *toolBar;
@property (nonatomic, weak) QJComposePhotoView *photoView;

@end

@implementation QJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavBar];
    
    // 添加TextView
    [self setupTextView];
    
    // 添加自定义工具栏
    [self setupToolBar];
    
    // 添加ComposePhotoView
    [self setupComposePhotoView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 成为第一响应者,叫出键盘
    [self.textView becomeFirstResponder];
}
/**
 *  设置导航栏
 */
- (void)setupNavBar {
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
/**
 *  添加TextView
 */
- (void)setupTextView {
    // 创建输入控件
    QJTextView *textView = [[QJTextView alloc] init];
    [self.view addSubview:textView];
    textView.delegate = self;
    textView.frame = self.view.frame;
    self.textView = textView;
    
    // 设置占位文字
    textView.placehoder = @"分享新鲜事...";
    
    // 设置字体大小
    textView.font = [UIFont systemFontOfSize:15];
    
    // 监听键盘
    // 监听键盘显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘处理
/**
 *  显示键盘
 */
- (void)keyboardShow:(NSNotification *)noti {
    // 键盘弹出所需时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘结束弹出的位置
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = rect.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    }];
}
/**
 *  隐藏键盘
 */
- (void)keyboardHide:(NSNotification *)noti {
    // 键盘推出所需时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 恢复键盘位置
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  添加自定义工具栏
 */
- (void)setupToolBar {
    QJComposeToolBar *toolBar = [[QJComposeToolBar alloc] init];
    toolBar.width = QJScreenW;
    toolBar.height = 44;
    toolBar.y = self.textView.height - toolBar.height;
    toolBar.x = 0;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    // 点击工具栏按钮触发事件的block
    toolBar.composeToolBarButtonClickedBlock = ^(UIButton *btn) {
        switch (btn.tag) {
            case QJComposeToolbarButtonTypeCamera:
                [self openCamera];
                break;
            case QJComposeToolbarButtonTypePicture:
                [self openAlbum];
                break;
            case QJComposeToolbarButtonTypeMention:
                NSLog(@"------QJComposeToolbarButtonTypeMention");
                break;
            case QJComposeToolbarButtonTypeEmotion:
                NSLog(@"------QJComposeToolbarButtonTypeEmotion");
                break;
            case QJComposeToolbarButtonTypeTrend:
                NSLog(@"------QJComposeToolbarButtonTypeTrend");
                break;
            default:
                break;
        }
    };
}
/**
 *  添加发送相片View
 */
- (void)setupComposePhotoView {
    QJComposePhotoView *photoView = [[QJComposePhotoView alloc] init];
    [self.textView addSubview:photoView];
    photoView.x = 0;
    photoView.y = 70;
    photoView.width = QJScreenW;
    photoView.height = self.textView.height;
    self.photoView = photoView;
}
/**
 *  打开照相机
 */
- (void)openCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return ;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openAlbum {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return ;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  取消
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送
 */
- (void)send {
    // 1.发表微博
    if (self.photoView.images.count) {
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发布微博加图片
 */
- (void)sendStatusWithImage {
    // 封装请求参数
    QJSendStatusParam *params = [[QJSendStatusParam alloc] init];
    params.access_token = [QJAccountTool account].access_token;
    params.status = self.textView.text;
    
    // 发送POST请求
    [QJStatusTool SendStatusWithPhotoWithParams:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photoView.images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        // 拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } success:^(QJSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}
/**
 *  发布微博不加图片
 */
- (void)sendStatusWithoutImage {
    // 封装请求参数
    QJSendStatusParam *params = [[QJSendStatusParam alloc] init];
    params.access_token = [QJAccountTool account].access_token;
    params.status = self.textView.text;
    
    // 发送POST请求
    [QJStatusTool SendStatusWithoutPhotoWithParams:params success:^(QJSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}

#pragma mark - textView代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

-(void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - UIImagePickerController代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.photoView addImage:info[UIImagePickerControllerOriginalImage]];
    // 退出相册
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
