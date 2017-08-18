//
//  AddRecieptViewController.h
//  Receipts++
//
//  Created by Hirad on 2017-08-17.
//  Copyright © 2017 Hirad. All rights reserved.
//

//#import "ViewController.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "AppDelegate.h"

@interface AddRecieptViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UITextField *note;
@property (nonatomic, strong) NSArray<NSString*> *tagList;






@end
