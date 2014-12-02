//
//  StartView.m
//  TouchTimer
//
//  Created by MasaruMiyamoto on 2014/11/28.
//  Copyright (c) 2014年 MasaruMiyamoto. All rights reserved.
//

#import "StartView.h"

@interface StartView ()<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation StartView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UIPickerのインスタンス化
    //    picker = [[UIPickerView alloc]init];
    
    // デリゲートを設定
    self.picker.delegate = self;
    
    // データソースを設定
    self.picker.dataSource = self;
    
    // 選択インジケータを表示
    self.picker.showsSelectionIndicator = YES;
    
    // UIPickerのインスタンスをビューに追加
    [self.view addSubview:self.picker];
    
//    self.picker.hidden = YES;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

/**
 * ピッカーに表示する行数を返す
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return 5;
    }else{
        return 59;
    }
}

/**
 * 行のサイズを変更
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return 100.0;
            break;
            
        case 1: // 2列目
            return 100.0;
            break;
            
        default:
            return 0;
            break;
    }
}


/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return [NSString stringWithFormat:@"%ld 分", (long)row];
            break;
            
        case 1: // 2列目
            return [NSString stringWithFormat:@"%ld　秒", (long)row];
            break;
            
        default:
            return 0;
            break;
    }
}


/**
 * ピッカーの選択行が決まったとき
 */
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 1列目の選択された行数を取得
    NSInteger val0 = [pickerView selectedRowInComponent:0];
    
    // 2列目の選択された行数を取得
    NSInteger val1 = [pickerView selectedRowInComponent:1];
    
    int countH = (int)val0;
    int countM = (int)val1;
    
    NSString *outLabel = [NSString stringWithFormat:@"%d",countH];
    outLabel = [outLabel stringByAppendingString:@":"];
    
    if(countM / 10 == 0)
        outLabel = [outLabel stringByAppendingString:@"0"];
    outLabel = [outLabel stringByAppendingString:[NSString stringWithFormat:@"%d",countM]];
    outLabel = [outLabel stringByAppendingString:@"."];
    
    outLabel = [outLabel stringByAppendingString:@"00"];
    
    self.label.text = outLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"segue"]) {
        //遷移先のViewController
        ViewController *label = [segue destinationViewController];
        label.setLabel = self.label.text;
    }
}

@end
