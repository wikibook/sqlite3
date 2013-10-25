//
//  sqlmanagerViewController.h
//  sqlmanager
//
//  Created by HoChul Shin on 10. 5. 1..
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sqlmanagerViewController : UIViewController 
	<UITableViewDelegate, UITableViewDataSource>
{
	UITextField *sqlField;
	UITableView *table;
}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UITextField *sqlField;
- (IBAction)textFieldDoneEditing:(id)sender;

@end

