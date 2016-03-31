//
//  DealDataModel.h
//  btn
//
//  Created by Jiayu_Zachary on 15/11/13.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealDataModel : NSObject

+ (instancetype)defaultDealDataModel;

/*!
 @method
 @abstract 时间重新组合,返回所有组合当中最短时间的下标
 @discussion 传入数据源 经纬度数据源格式与时间格式一致
 @param 时间集合
 @param nill
 @result 返回 >=0 正确, 返回-1 错误
 */
- (NSInteger)startSort:(NSMutableArray *)dataSource;

/*!
 @method
 @abstract 数据源重新组合,返回所有组合的集合
 @discussion 传入数据源 经纬度数据源格式与时间格式一致
 @param 数据源集合
 @param nil
 @result 数据源个数 >=0 正确, 否则错误
 */
- (NSMutableArray *)startSortWithDataSource:(NSMutableArray *)dataSource;

@end
