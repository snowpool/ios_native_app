//
//  SPLConstants.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#define SPLAuthTokenKey @"SPLAuthTokenKey"
#define SPLServiceBaseURL @"http://api.snowpool.org:3000"

#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

#define NSStringFromBOOL(b) ((b) ? @"YES" : @"NO")
