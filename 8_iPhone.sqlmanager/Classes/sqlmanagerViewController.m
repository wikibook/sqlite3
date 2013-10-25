//
//  sqlmanagerViewController.m
//  sqlmanager
//
//  Created by HoChul Shin on 10. 5. 1..
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "sqlmanagerViewController.h"
#import "sqlite3.h"

@implementation sqlmanagerViewController
@synthesize table;
@synthesize sqlField;

static NSMutableArray *titles;
static NSMutableArray *subtitles;
NSString *result;

sqlite3 *db;
sqlite3 *history;

#define CONST_Cell_height 44.0f
#define CONST_Cell_width 270.0f

#define CONST_textLabelFontSize     17
#define CONST_detailLabelFontSize   15

static UIFont *subFont;
static UIFont *titleFont;

- (UIFont*) TitleFont;
{
	if (!titleFont) titleFont = [UIFont boldSystemFontOfSize:CONST_textLabelFontSize];
	return titleFont;
}

- (UIFont*) SubFont;
{
	if (!subFont) subFont = [UIFont systemFontOfSize:CONST_detailLabelFontSize];
	return subFont;
}

- (UITableViewCell*) CreateMultilinesCell :(NSString*)cellIdentifier
{
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
													reuseIdentifier:cellIdentifier] autorelease];

	cell.textLabel.numberOfLines = 0;
	cell.textLabel.font = [self TitleFont];

	cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.font = [self SubFont];

	return cell;
}


- (void)viewDidLoad {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
    NSString *db_path = [documentsDirectory stringByAppendingPathComponent:@"default.db"];
    sqlite3_open([db_path UTF8String], &db);
	
    NSString *history_path = [documentsDirectory stringByAppendingPathComponent:@"history.db"];
    sqlite3_open([history_path UTF8String], &history);	
	sqlite3_exec(history, "CREATE TABLE IF NOT EXISTS history (id int, query text, result text, PRIMARY KEY(id));", NULL, NULL, NULL);
	
	if (!titles)
		titles = [[NSMutableArray arrayWithObjects: nil] retain];
	if (!subtitles)
		subtitles = [[NSMutableArray arrayWithObjects: nil] retain];
	
	// get history data
	int row;
	int column;
	char **res;
	sqlite3_get_table( history,
					  "SELECT query, result FROM history DESC;",
					  &res,
					  &row, &column, 
					  NULL );
	
	for(int i=0; i<row; i++){
		NSLog(@"[history] %s, %s", res[i*2], res[i*2+1]);
		[titles insertObject : [NSString stringWithFormat:@"%s", res[i*2+2]] atIndex:0 ];
		[subtitles insertObject : [NSString stringWithFormat:@"%s", res[i*2+3]] atIndex:0 ];
	}
	
	sqlite3_free_table(res);
	
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[super viewDidUnload];
	
	sqlite3_close(db);
	sqlite3_close(history);
}

- (void)dealloc {
	[sqlField release];
	[table release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX([titles count], [subtitles count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self CreateMultilinesCell:CellIdentifier];
    }

    cell.textLabel.text = [titles objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [subtitles objectAtIndex:indexPath.row];	
	
	return cell;
}

- (int) heightOfCellWithTitle :(NSString*)titleText
andSubtitle:(NSString*)subtitleText
{
	CGSize titleSize = {0, 0};
	CGSize subtitleSize = {0, 0};
	
	if (titleText && ![titleText isEqualToString:@""])
		titleSize = [titleText sizeWithFont:[self TitleFont]
						  constrainedToSize:CGSizeMake(CONST_Cell_width, 4000)
							  lineBreakMode:UILineBreakModeWordWrap];
	
	if (subtitleText && ![subtitleText isEqualToString:@""])
		subtitleSize = [subtitleText sizeWithFont:[self SubFont]
								constrainedToSize:CGSizeMake(CONST_Cell_width, 4000)
									lineBreakMode:UILineBreakModeWordWrap];
	
	return titleSize.height + subtitleSize.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *title = [titles objectAtIndex:indexPath.row];
	NSString *subtitle = [subtitles objectAtIndex:indexPath.row];
	
	int height = 10 + [self heightOfCellWithTitle:title andSubtitle:subtitle];
	return (height < CONST_Cell_height ? CONST_Cell_height : height);
}

int callback(void* data, int ncols, char** values, char** headers)
{
	int i;
	NSString *tmpString;
	for(i=0;i<ncols;i++){
		if (i==0) tmpString = [NSString stringWithFormat:@"%s=%s", headers[i], values[i]];
		else tmpString = [NSString stringWithFormat:@", %s=%s", headers[i], values[i]];
		result = [result stringByAppendingString:tmpString];
	}
	result = [result stringByAppendingString:@"\n"];
	return 0;
}

- (IBAction)textFieldDoneEditing:(id)sender{
	result = @"";
	char *errmsg;
	NSLog(@"sql input : %@", sqlField.text);
	
	int rc = sqlite3_exec(db, [sqlField.text UTF8String], callback, NULL, &errmsg);
	if (rc) {
		NSLog(@"rc = %d", rc);
		NSLog(@"sqlite3_exec error : %s", errmsg);
		result = [NSString stringWithFormat:@"%s", errmsg];
	}
	
	[subtitles insertObject : result atIndex:0];
	[titles insertObject : sqlField.text atIndex:0];
	
	char *zSQL = sqlite3_mprintf("INSERT INTO history (query, result) VALUES('%q', '%q')", [sqlField.text UTF8String], [result UTF8String]);
	sqlite3_exec(history, zSQL, 0, 0, 0);
	sqlite3_free(zSQL);
	
	[table reloadData];
	[sender resignFirstResponder];
}
@end
