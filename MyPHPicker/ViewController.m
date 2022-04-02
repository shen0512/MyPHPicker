//
//  ViewController.m
//  MyPHPicker
//
//  Created by Shen on 2022/4/2.
//

#import "ViewController.h"
#import <PhotosUI/PhotosUI.h>
@interface ViewController ()<PHPickerViewControllerDelegate>{
    PHPickerConfiguration *cfg;
    PHPickerViewController *phPickerViewController;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cfg = [[PHPickerConfiguration alloc] init];
    cfg.selectionLimit = 1; //照片選擇數量
    cfg.filter = [PHPickerFilter imagesFilter];
    
    phPickerViewController = [[PHPickerViewController alloc] initWithConfiguration:cfg];
    phPickerViewController.delegate = self;
    
}

- (IBAction)btnClick:(id)sender {
    [self presentViewController:phPickerViewController animated:YES completion:nil];
}

-(void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 只顯示一張圖
    if([results count]!=0){
        PHPickerResult *result = [results firstObject];
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error){
           if ([object isKindOfClass:[UIImage class]]){
              dispatch_async(dispatch_get_main_queue(), ^{
                  self.imageView.image = (UIImage*)object;
              });
           }
        }];
    }
}

@end
