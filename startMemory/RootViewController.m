//
//  RootViewController.m
//  startMemory
//
//  Created by Artist on 2/24/16.
//  Copyright © 2016 ever8greener. All rights reserved.
//

#import "RootViewController.h"
#import "Car.h"
//-----------------------------
//      오토릴리즈 클래스
//-----------------------------
#pragma mark - Autorelease pool test

@interface AutoreleasePoolTester : NSObject{
}
@end

@implementation AutoreleasePoolTester
-(void)dealloc{
    [super dealloc];
    NSLog(@"dealloc 수행");
}

@end
//-----------------------------
//      썸 클래스
//-----------------------------
#pragma mark - 썸 클래스
@interface Sumsum : NSObject{
    int sum;
    NSString* name;
}
@property (retain) NSString* name;

@end


@implementation Sumsum
@synthesize name;

- (int)sum{
    return sum;
}
- (void)setSum:(int)number{
    sum = number;
}
@end

//void addNumber(int number){
//    
//    sum  = sum + number;
//    printf("sum = %d\n",sum);
//}

void addNumber(Sumsum* instance, int number){
    //[instance setSum:[instance sum]+number]; // 원래 값 + number
    
    //또는
    instance.sum = instance.sum + number;
    
    //printf("[instance sum = %d\n",[instance sum]);
    printf("%s = %d\n",[instance.name UTF8String],instance.sum);
}


//-----------------------------
//      썸 클래스 - 2버전
//-----------------------------
#pragma mark - 썸 클래스
@interface SumRetain : NSObject{
    int sum;
    NSString* name;
}
@property (copy) NSString* name;

@end


@implementation SumRetain
@synthesize name;

- (int)sum{
    return sum;
}
- (void)setSum:(int)number{
    sum = number;
}
@end

//-----------------------------
//      family 클래스 on Saturday
//-----------------------------
#pragma mark - family 클래스
@interface Family : NSObject{
    int sum;
    NSString* name;
}
@property (copy) NSString* name;
@end

@implementation Family
@synthesize name;

- (int)sumFamily{
    return sum;
}
- (void)setSum:(int)number{
    sum = number;
}
@end


//-----------------------------
//      루트뷰 컨트롤러
//-----------------------------

#pragma mark - RootViewController.

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //여기부터 주석달기 시작할 필요 있다!
    
    //sum retain test
    
    SumRetain *sumR = [[SumRetain alloc]init]  ;
    SumRetain *sumS = [[SumRetain alloc]init]  ;
    
    //NSString* strName = @"HahaName";
    NSString* strName = [NSMutableString stringWithFormat:@"My Name is mutableString (stringWithFmt사용)"];//saturday branch에서 작성중임.
    
    [sumR setName:strName];
    [sumS setName:strName];
    
    printf("[주소]\nname:%p \nsumR:%p \nsumS:%p",strName,[sumR name],[sumS name]);
    printf("\n retaincount: %d\n",[strName retainCount]);
    
    //1차 테스트
    
    Sumsum *sumX =[[Sumsum alloc]init];
    Sumsum *sumY =[[Sumsum alloc]init];
    
    addNumber(sumX, 1); //외부함수???p143  //함수포인터,integer 가 파라미터임.
    addNumber(sumY, 1);
    addNumber(sumX, 1);
//    [sumX addNumber:2];
//    [sumY addNumber:2];
//    [sumX addNumber:2];
    [sumX release];
    [sumY release];
    
    //NSLog(@"sumZ's sum = %d",[sumZ sum]);
    
    
    //썸테스트
    
    Sumsum *sumA = [[Sumsum alloc]init]  ;
    Sumsum *sumB = [[Sumsum alloc]init]  ;
    
    [sumA setName:@"I am sumA"];
    [sumB setName:@"I am sumB"];
    
    [sumA setSum:5];
    NSLog(@"sumA's sum = %d",[sumA sum]);
    
    
    addNumber(sumA, 1);
    addNumber(sumB, 1);
    addNumber(sumA, 1);
    
    
    columnTitle = @"hello start";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
     Car *myCar = [[Car alloc]init];  // 여기서  retainCnt = 1이되고.
    myCar.cNumOfWheel = 5;
    NSLog(@"처음car cnt: %lu",(unsigned long)[myCar retainCount]);
    
    [myCar retain];
    NSLog(@"리테인후 car cnt: %lu",(unsigned long)[myCar retainCount]); // 이것실행후 2가되고,
    [myCar release]; //1
    [myCar release]; //0
    //[myCar release]; //이거 한번 더하면 Crash...
 
    // 참고 - 여기에 car class 접목하자.
    // http://simyungk.tistory.com/35
    // http://www.raywenderlich.com/97886/instruments-tutorial-with-swift-getting-started
    
    
    //-----------------------------------------------------------------
    // __block 가 없다면 아래 (^aBlock) 을 호출하면 aString 을 변경할 수 없다!!!
    // http://stackoverflow.com/questions/19227982/using-block-and-weak
    //-----------------------------------------------------------------
    
    __block NSString *aString = @"Hey!";
    void(^aBlock)() = ^{ aString = @"Hello!"; }; // without __block you couldn't modify aString
    NSLog(@"%@", aString); // Hey!
    aBlock();
    NSLog(@"%@", aString); // Hello!
    
    
}
-(void)dealloc{
    [super dealloc];
    NSLog(@"deallocated");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
     cell.textLabel.text = columnTitle; //@"hello in 1st";
     return cell;
}
 

 #pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc]init];
    AutoreleasePoolTester *test = [[AutoreleasePoolTester alloc]init];
    [test autorelease];

    //[test release];
    [test retain];

    [pool release];
    
    //이렇게 하면 다른 임시로 pool을 먼저 비울 수 있다.
    // 모든 변수의 릴리즈가 한꺼번에 처리되려면 시간이 걸리기 때문에
    // 우선적으로 대량으로  auto release 가 필요하다면 이런식으로 하면 된다.
    // nest 형식으로 autorelease 를 구현하면 됨.( ios debug and 최적화기법,p99 )
    
 
    RootViewController *detailViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


@end
