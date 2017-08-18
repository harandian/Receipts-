//
//  AddRecieptViewController.m
//  Receipts++
//
//  Created by Hirad on 2017-08-17.
//  Copyright © 2017 Hirad. All rights reserved.
//

#import "AddRecieptViewController.h"


@interface AddRecieptViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *tagTable;
@property (nonatomic, strong) NSArray<Receipt*> *reciepts;
@property AppDelegate *appdelegate;
@property (nonatomic, strong) NSDate *date;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSMutableSet<NSString*> *selectedCellsGlobal;

@end

@implementation AddRecieptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
// Do any additional setup after loading the view.
    self.appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagList.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell" forIndexPath:indexPath];
 
 // Configure the cell...
     
     cell.textLabel.text = self.tagList[indexPath.row];
//     cell.backgroundColor = [UIColor magentaColor];
 
 return cell;
 }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [NSString stringWithFormat:@"Catagory"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray<NSIndexPath *> *selectedCells = [tableView indexPathsForSelectedRows];
    NSLog(@"%@",selectedCells);
    
    self.selectedCellsGlobal = [NSMutableSet new];
    
    for (NSIndexPath *temp in selectedCells) {
        

        switch (temp.row) {
            case 0:
                [self.selectedCellsGlobal addObject:self.tagList[0]];
                break;
            case 1:
                [self.selectedCellsGlobal addObject:self.tagList[1]];
                break;
            case 2:
                [self.selectedCellsGlobal addObject:self.tagList[2]];
                break;
            default:
                break;
        }
        
    }

//    [self receiptSetup];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 1) {
        
        [textField resignFirstResponder];
        
    }
    
    if (textField.tag == 2) {
        
        [textField resignFirstResponder];
        
    }
    return YES;
}

- (void) receiptSetup {
    
    
    Receipt *reciept = [[Receipt alloc] initWithContext:self.appdelegate.persistentContainer.viewContext];
    
//    Tag *tag = [[Tag alloc] initWithContext:self.appdelegate.persistentContainer.viewContext];
    
    NSMutableOrderedSet *tagSet = [NSMutableOrderedSet new];
    
    for ( NSString* tagName in self.selectedCellsGlobal)
    {
         Tag *tag = [[Tag alloc] initWithContext:self.appdelegate.persistentContainer.viewContext];
        tag.tagName = tagName;
        
        [tagSet addObject:tag];
    }
    reciept.amount = [NSDecimalNumber decimalNumberWithString:self.amount.text];
    reciept.note = self.note.text;
    reciept.timeStamp = self.datePicker.date;
    [reciept addTags:tagSet];

    
    
    
}

- (IBAction)save:(id)sender {
    [self receiptSetup];
    [self.appdelegate saveContext];
    
    NSError *error = nil;
    NSFetchRequest<Tag *> *fetchTagRequest = [Tag fetchRequest];
    NSArray<Tag *> *tags = [self.appdelegate.persistentContainer.viewContext executeFetchRequest:fetchTagRequest error:&error];
    
    for (Tag* tag in tags) {
        NSLog(@"%@",tag.tagName);
    }
    
    NSFetchRequest<Receipt *> *fetchRecieptRequest = [Receipt fetchRequest];
    NSArray<Receipt *> *receipts = [self.appdelegate.persistentContainer.viewContext executeFetchRequest:fetchRecieptRequest error:&error];
    
    
      
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
