//
//  InshortsView.h
//  InshortsTest
//
//

#import <UIKit/UIKit.h>
@class PMPBaseView;

@protocol InshortsViewDataSource, InshortsViewDelegate ,ThemeColorChangeResponser;

@interface InshortsView : UIView

-(instancetype)initWithFrame:(CGRect)frame;
- (void)layoutCards;
-(void)startAutoPlay;
-(void)updateColors;
@property (nonatomic, weak) id<InshortsViewDataSource> dataSource;
@property (nonatomic, weak) id<InshortsViewDelegate> delegate;
@property (nonatomic) NSInteger numberOfItems;
@property (nonatomic) NSInteger currentItemIndex;
@end

@protocol InshortsViewDataSource <NSObject>

- (NSInteger)numberOfItemsInInshortsView:(InshortsView *)inshortsView;
- (PMPBaseView *)inshortsView:(InshortsView *)inshortsView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view;

@end


@protocol InshortsViewDelegate <NSObject>
@optional
- (void)inshortsViewCurrentItemIndexDidChange:(InshortsView *)inshortsView;
- (void)inshortsView:(InshortsView *)inshortsView didSelectItemAtIndex:(NSInteger)index;

@end
