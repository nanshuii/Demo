#  LENEasyTableView


##  LENEasyTableViewCellType
#### LENEasyTableViewCellTypeText 
主要是文本类型的cell，用来做设置页面

对于TextModel有几种不同的初始化方式，主要用于分区不同类型的设置

- (instancetype)initWithCenterTitle:(NSString *)centerTitle;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle switchValue:(BOOL)switchValue;

- (instancetype)initWithCenterTitle:(NSString *)centerTitle leftImage:(UIImage *)leftImage switchValue:(BOOL)switchValue;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle rightTitle:(NSString *)rightTitle leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle switchValue:(BOOL)switchValue;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle subTitle:(NSString *)subTitle leftImage:(UIImage *)leftImage switchValue:(BOOL)switchValue;


