UIAlertView-Blocks
==================

Support for blocks in UIAlertView to replace the use of `UIAlertViewDelegate`.

Description
-----------

This simple category adds support to use block callbacks with `UIAlertView`.
It doesn't override the use of `UIAlertViewDelegate` since the delegate methods will still be called if a delegate is provided and assuming that they are implemented.

Delegate-Block Map
------------------

<table>
    <tr>
        <th>Delegate Method</th>
        <th>Block Method</th>
    </tr>
    <tr>
        <td>alertView:clickedButtonAtIndex:</td>
        <td>setOnDidSelectButton:</td>
    </tr>
    <tr>
        <td>alertView:willDismissWithButtonIndex:</td>
        <td>setOnWillDismiss:</td>
    </tr>
    <tr>
        <td>alertView:didDismissWithButtonIndex:</td>
        <td>setOnDidDismiss:</td>
    </tr>
</table>


Usage
-----

**Note: make sure to import the category's header file before using the category**

Initialize the `UIAlertView` as usual using `initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:`.
You can then set the blocks to define what to do when the alert view is being dismissed.

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert View Title" 
													    message:@"Alert View Message" 
													   delegate:nil 
											  cancelButtonTitle:@"Cancel" 
											  otherButtonTitles:@"Okay"];
											  
	[alertView setOnDidDismiss:^(NSUInteger buttonIndex) {
		if (buttonIndex == alertView.cancelButtonIndex)
		{
			NSLog(@"Cancel Button Tapped");
		}
		else
		{
			NSLog(@"Okay Button Tapped");
		}
	}];
	
	[alertView show];

If you set a delegate that implements the `UIAlertViewDelegate`'s methods, they will be called as well.