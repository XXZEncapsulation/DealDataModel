//
//  DealDataModel.m
//  btn
//
//  Created by Jiayu_Zachary on 15/11/13.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "DealDataModel.h"

@implementation DealDataModel {
    NSMutableArray *_timeResultArr; //时间的组合
}

+ (instancetype)defaultDealDataModel {
    static DealDataModel *_dealDataModel = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _dealDataModel = [[DealDataModel alloc] init];
    });
    
    return _dealDataModel;
}

/*!
    时间重新组合,返回所有组合当中最短时间的下标
 */
 //返回 >= 0 数据正确, -1 数据错误
- (NSInteger)startSort:(NSMutableArray *)dataSource {
    
    if (dataSource.count) {
        //初始化
        _timeResultArr = [NSMutableArray array];
        //开始组合
        [self combine:[NSMutableArray array] data:dataSource curr:0 count:(int)dataSource.count];
        //    NSLog(@" \n%@ ",_timeResultArr);
        
        NSInteger needIndex = [self compare:_timeResultArr];
        //    NSLog(@"needIndex = %ld", needIndex);
        
        return needIndex;
    }
    
    return -1;
}

/*!
    数据源重新组合,返回所有组合的集合
 */
- (NSMutableArray *)startSortWithDataSource:(NSMutableArray *)dataSource {
    
    if (dataSource.count) {
        //初始化
        _timeResultArr = [NSMutableArray array];
        
        [self combine:[NSMutableArray array] data:dataSource curr:0 count:(int)dataSource.count];
        
        return _timeResultArr;
    }
    
    return nil;
}

/*!
 dataSourceArr 中存储的是时间 => 秒
 返回 >= 0 数据正确, -1 数据错误
 */
- (NSInteger)compare:(NSMutableArray *)dataSourceArr {
    NSInteger needIndex = -1;
    
    if (dataSourceArr.count) {//若有数据
        
        NSMutableArray *tempTimeM = [NSMutableArray array];
        int count = (int)dataSourceArr.count;
        
        for (int i=0; i<count; i++) {
            NSArray *tempTimeArr = [dataSourceArr objectAtIndex:i];
            
            NSInteger time = 0;
            for (NSString *timeStr in tempTimeArr) {
                time = [timeStr integerValue] +time;
            }
            
            //将每个数组的时间之和加入数组
            [tempTimeM addObject:@(time)];
            
        }
        
        if (tempTimeM.count) {
            //取出最小值
            NSNumber *minTime=[tempTimeM valueForKeyPath:@"@min.integerValue"];
            //取出下标,若数组中有多个相同的元素,只取找到的第一个
            NSInteger index = [tempTimeM indexOfObject:minTime];
            
            return index;
        }
        
    }
    
    return needIndex;
}

/*!
 递归取元素,重新组合
 最终数据源中的数组个数一致,否则数据错误
 */
- (void)combine:(NSMutableArray *)result data:(NSMutableArray *)data curr:(int)currIndex count:(int)count {
    
    if (currIndex == count) {
        
        [_timeResultArr addObject:[result mutableCopy]];
        [result removeLastObject];
        
    }else {
        NSArray* array = [data objectAtIndex:currIndex];
        
        for (int i = 0; i < array.count; ++i) {
            [result addObject:[array objectAtIndex:i]];
            //进入递归循环
            [self combine:result data:data curr:currIndex+1 count:count];
            
            if ((i+1 == array.count) && (currIndex-1>=0)) {
                [result removeObjectAtIndex:currIndex-1];
            }
        }
    }
}

@end
