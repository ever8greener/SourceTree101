//
//  main.m
//  startMemory
//
//  Created by Artist on 2/24/16.
//  Copyright © 2016 ever8greener. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"


//-----------------------------
//      차 클래스
//-----------------------------

@interface CarStore : NSObject

- (NSMutableArray *)inventory;

@end
//This manually declares the accessors for a property called inventory. Our first iteration of CarStore.m provides a straightforward implementation of the getter and setter, along with an instance variable to record the object:

// CarStore.m 에 해당하는 내용.

@implementation CarStore {
    NSMutableArray *_inventory;
}

- (NSMutableArray *)inventory {
    return _inventory;
}

- (void)setInventory:(NSMutableArray *)newInventory {
//    _inventory = newInventory;        // 이렇게하면 weak reference 가 형성됨.
    
    if (_inventory == newInventory) {
        return;
    }
    NSMutableArray *oldValue = _inventory;
    _inventory = [newInventory retain];
    [oldValue release];
    
//    
//    if( _inventory == newInventory){
//        return ;
//    }
//    NSMutableArray* oldObj = _inventory;
//    _inventory = [newInventory retain]; // 이 경우 strong reference 형성. (retain과 assign동시에 해주고, 객체자체를 return 함. / perform the retain and assignment in a single line.)
//    [oldObj release];
}

@end

//-----------------------------
//      main 함수
//-----------------------------

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //예제: http://rypress.com/tutorials/objective-c/memory-management
        
        NSMutableArray *inventory = [[NSMutableArray alloc] init];
        [inventory addObject:@"Honda Civic"];
        
        
        CarStore* superStore = [[CarStore alloc]init];
        [superStore setInventory:inventory];
        
        NSLog(@"rt cnt:%d (릴리즈전)",[inventory retainCount]);
        [inventory release];
        NSLog(@"rt cnt:%d (릴리즈후)",[inventory retainCount]);
        //NSLog(@"%@", [superStore inventory]);
        
        [superStore release];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}



