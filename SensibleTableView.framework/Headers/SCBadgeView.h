/*
 *  SCBadgeView.h
 *  Sensible TableView
 *  Version: 5.2.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. YOU SHALL NOT DEVELOP NOR
 *	MAKE AVAILABLE ANY WORK THAT COMPETES WITH A SENSIBLE COCOA PRODUCT DERIVED FROM THIS 
 *	SOURCE CODE. THIS SOURCE CODE MAY NOT BE RESOLD OR REDISTRIBUTED ON A STAND ALONE BASIS.
 *
 *	USAGE OF THIS SOURCE CODE IS BOUND BY THE LICENSE AGREEMENT PROVIDED WITH THE 
 *	DOWNLOADED PRODUCT.
 *
 *  Copyright 2011-2015 Sensible Cocoa. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */


#import "SCGlobals.h"

/****************************************************************************************/
/*	class SCBadgeView	*/
/****************************************************************************************/ 
/**	
 This class provides as a badge view similar to the one used by iPhone's mail application to
 display the number of messages in an inbox. SCBadgeView is typically used by SCTableViewCell to display these kind of badges.
 
 Sample use:
    SCTableViewCell *cell = [SCTableViewCell cellWithText:@"Number of pending tasks"];
    cell.badgeView.text = @"50";
 
 See also: SCTableViewCell
 */
@interface SCBadgeView : UILabel

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Configuration
//////////////////////////////////////////////////////////////////////////////////////////

@end
