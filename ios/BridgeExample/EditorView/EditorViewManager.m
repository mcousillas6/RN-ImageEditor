//
//  EditorViewManager.m
//  BridgeExample
//
//  Created by Mauricio Cousillas on 9/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(EditorViewManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(onImageChange, RCTDirectEventBlock)
@end
