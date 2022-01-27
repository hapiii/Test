//
//  KeyBoardViewController.m
//  Test
//
//  Created by 强王 on 2022/1/25.
//

#import "KeyBoardViewController.h"

@interface KeyBoardViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *tf;
@end

@implementation KeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)tfKeyboard {
    _tf = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    _tf.delegate = self;
    _tf.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tf];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    vie.backgroundColor = [UIColor redColor];
    self.tf.inputAccessoryView = self.tf.inputAccessoryView != nil ? nil : vie;
    [self.tf reloadInputViews];
     
    /*
    if ( [self.tf isFirstResponder]) {
        [self.tf resignFirstResponder];
    } else {
        [self.tf becomeFirstResponder];
    }
     */
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (void)keyboardHidden:(NSNotification *)noti {
    NSLog(@"keyboardHidden");
}

- (void)keyboardShow:(NSNotification *)noti {
    NSLog(@"keyboardShow");
}

@end
