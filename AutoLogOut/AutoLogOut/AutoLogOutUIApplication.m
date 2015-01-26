/*
 * Copyright 2014 Pablo GM <invanzert@gmail.com>. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "AutoLogOutUIApplication.h"


@interface AutoLogOutUIApplication()
{

}

@end


@implementation AutoLogOutUIApplication


#pragma mark - Detect events

- (void)sendEvent:(UIEvent *)event
{
	[super sendEvent:event];
	
	// Check if there was a touch event
    NSSet *allTouches = [event allTouches];
    
    if ([allTouches count] > 0)
    {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        
        if (phase == UITouchPhaseBegan)
        {
            if ( self.enableAutoLogout )
            {
                [self resetAlarm];
            }
		}
    }
    
    PGMLogger("Event");
}


#pragma mark - Alarm

- (void)resetAlarm
{
    self.timeTracker = [NSDate date];
    
    if ( [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive )
    {
        [self scheduleAlarm];
    }
    
    PGMLogger("Reset Alarm");
}

- (void)scheduleAlarm
{
    UIApplication* app              = [UIApplication sharedApplication];
    NSArray*    oldNotifications    = [app scheduledLocalNotifications];
    
    // Clear out the old notification before scheduling a new one.
    if ([oldNotifications count] > 0)
    {
        [app cancelAllLocalNotifications];
    }
    
    // Create a new notification.
    UILocalNotification* alarm      = [[UILocalNotification alloc] init];
    
    // We do not want the alert to appear,
    // just the didReceiveLocalNotification to be called
    if (alarm)
    {
        alarm.fireDate          = [NSDate dateWithTimeIntervalSinceNow:kTimeout];
        alarm.repeatInterval    = 0;
        alarm.timeZone          = [NSTimeZone defaultTimeZone];
        alarm.hasAction         = NO;
        
        [app scheduleLocalNotification:alarm];
    }
}


#pragma Dealloc

- (void)dealloc
{
    self.timeTracker = nil;
}

@end