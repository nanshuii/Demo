//
//  LENDocumentReceiveViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/4/29.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENDocumentReceiveViewController.h"
#import "LENDocumentReceiveCollectionViewCell.h"
#import "LENDocumentModel.h"

#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
@interface LENDocumentReceiveViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIDocumentInteractionControllerDelegate>

@property (nonatomic, copy) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableDictionary *sources;

@property (nonatomic, strong) NSMutableArray *keys;

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation LENDocumentReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.sources = [NSMutableDictionary new];
    self.keys = [NSMutableArray new];
    [self.view addSubview:self.collectionView];
    // 文件的获得
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folder = [DocumentPath stringByAppendingPathComponent:@"Inbox"];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:folder error:&error];
    if (error) {
        NSLog(@"error = %@", error);
        self.messageLabel.text = error.description;
        self.messageLabel.hidden = NO;
        [self.view bringSubviewToFront:self.messageLabel];
    }
    NSLog(@"file lists = %@", fileList.description);
    if (fileList.count == 0) {
        
    } else {
        [self handleFiles:fileList folder:folder];
    }
    
    
    
    // 文件预览
    self.documentController = [UIDocumentInteractionController new];
    self.documentController.delegate = self;
}

# pragma mark -- 文件处理
- (void)handleFiles:(NSArray *)files folder:(NSString *)folder{
    for (NSString *path in files) {
        NSArray *paths = [path componentsSeparatedByString:@"."];
        if (paths.count > 1) {
            NSString *type = paths[paths.count-1];
            if ([self.keys containsObject:type]) {
                //
                
            } else {
                NSMutableArray *arrayNew = [NSMutableArray new];
                self.sources[type] = arrayNew;
                [self.keys addObject:type];
            }
            LENDocumentModel* model = [LENDocumentModel new];
            model.type = type;
            model.name = path;
            model.path = [folder stringByAppendingPathComponent:path];
            NSMutableArray *array = self.sources[type];
            [array addObject:model];
            self.sources[type] = array;
        }
    }
    
    NSLog(@"sources = %@", self.sources.description);
    [self.collectionView reloadData];
}

# pragma mark -- collectionView
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(80, 100);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 150) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"LENDocumentReceiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LENDocumentReceiveCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.keys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *key = self.keys[section];
    NSArray *array = self.sources[key];
    return array.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LENDocumentReceiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LENDocumentReceiveCollectionViewCell" forIndexPath:indexPath];
    NSString *key = self.keys[indexPath.section];
    NSArray *array = self.sources[key];
    if (array.count >= indexPath.row) {
        LENDocumentModel *model = array[indexPath.row];
        [cell cellWithName:model.name];
    } else {
        [cell cellWithName:@"empty"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSString *key = self.keys[indexPath.section];
    NSArray *array = self.sources[key];
    LENDocumentModel *model = array[indexPath.row];
    NSLog(@"path = %@", model.path);
    [self setDocumentFilePath:model.path];
    [self.documentController presentPreviewAnimated:YES];
}

- (void)setDocumentFilePath:(NSString *)filePath{
    // 设置filePath
    [self.documentController setURL:[NSURL fileURLWithPath:filePath]];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    // 设置快速预览的福页面
    return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
