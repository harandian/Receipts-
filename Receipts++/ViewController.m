//
//  ViewController.m
//  Receipts++
//
//  Created by Hirad on 2017-08-17.
//  Copyright © 2017 Hirad. All rights reserved.
//

#import "ViewController.h"
#import "AddRecieptViewController.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *recieptsTable;
@property AppDelegate *appdelegate;
@property (nonatomic, strong) NSArray *reciepts;
@property (nonatomic, strong) NSArray<NSString*> *tagList;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self fetchData];
    [self setUpTags];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tagList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reciepts.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
 
     Receipt *reciept = self.reciepts[indexPath.row];
     cell.textLabel.text = reciept.note;
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",reciept.tags.count];
 // Configure the cell...
 
 return cell;
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     AddRecieptViewController *addRecieptViewController = [segue destinationViewController];
     
     addRecieptViewController.tagList = [NSArray arrayWithArray:self.tagList];
     
     
 }
 

- (void) fetchData {
    
    NSError *error = nil;
    NSFetchRequest<Receipt*> *fetchReciepts = [Receipt fetchRequest];
    self.reciepts = [self.appdelegate.persistentContainer.viewContext executeFetchRequest:fetchReciepts error:&error];
    
}

- (void) setUpTags {

    
    NSString *tag1 = @"Personal";
    NSString *tag2 = @"Family";
    NSString *tag3 = @"Business";
    
    self.tagList =[NSArray arrayWithObjects:tag1,tag2,tag3, nil];
    
//
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *sectionName;
    
    switch (section) {
        case 0:
            sectionName = (NSString*)self.tagList[0];
            break;
        case 1:
            sectionName = (NSString*)self.tagList[1];
            break;
        case 2:
            sectionName = (NSString*)self.tagList[2];
            break;
            
        default:
            sectionName = @"";
            break;
    }
    
    
    return sectionName;
}


@end
