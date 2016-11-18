//
//  ViewController.m
//  test
//
//  Created by mobile_007 on 16/11/10.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"
#import <discovery.h>
#import <media-renderer.h>
#import <Foundation/Foundation.h>

using namespace dlna;

typedef Service::Result Result;

class MyDiscovery;


@interface ViewController (){
@private
    bool  m_is_scan;
    MyDiscovery * m_discovery;
    int m_volume;
}

@property (nonatomic,strong) UIButton *scan_btn;
@property (nonatomic,strong) UITextView *test0;
@property (nonatomic,strong) UITextView *test1;
@end

class MyDiscovery:public Discovery, public Discovery::Delegate{
public:
    MyDiscovery(ViewController* ctr): m_ctr(ctr){
        set_delegate(this);
    }
    
    virtual void discovery_change(Discovery * dis){
        vector<Service *> ls = this -> service(MEDIA_RENDERER);
        NSString *str = [NSString string];
        
        for (int i=0; i < ls.size(); i++) {
            str = [str stringByAppendingFormat:
                   @"friendly_name:%s, host:%s, port:%d\n",
                   ls[i]->get_friendly_name().c_str(),
                   ls[i]->get_hostname().c_str(),
                   ls[i]->get_port()
                   ];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [m_ctr.test0 setText:str];
            [m_ctr initButton:str];
        });
    }
    
    virtual void discovery_error(Discovery * dis, const string&err) {
        
    }
    
private:
    ViewController * m_ctr;
};



@implementation ViewController

- (void) initButton:(NSString *)str{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    m_is_scan = false;
    m_discovery = new MyDiscovery(self);
    m_volume = 10;
    
    self.test0 = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 375, 150)];
    _test0.backgroundColor = [UIColor redColor];
    [self.view addSubview:_test0];
    
    self.test1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 150, 375, 120)];
    _test1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_test1];
    
    self.scan_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_scan_btn setTitle:@"scan" forState:UIControlStateNormal];
    _scan_btn.frame = CGRectMake(0, CGRectGetMaxY(_test1.frame)+10, 80, 80);
    _scan_btn.backgroundColor = [UIColor grayColor];
    [_scan_btn addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scan_btn];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame = CGRectMake(CGRectGetMaxX(_scan_btn.frame)+10, _scan_btn.frame.origin.y, 80, 80);
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    startBtn.backgroundColor = [UIColor grayColor];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    stopBtn.frame = CGRectMake(CGRectGetMaxX(startBtn.frame)+10, startBtn.frame.origin.y, 80, 80);
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    stopBtn.backgroundColor = [UIColor grayColor];
    [stopBtn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    playBtn.frame = CGRectMake(0, CGRectGetMaxY(_scan_btn.frame)+10, 80, 80);
    [playBtn setTitle:@"play" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor grayColor];
    [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    pauseBtn.frame = CGRectMake(CGRectGetMaxX(playBtn.frame)+10, CGRectGetMaxY(_scan_btn.frame)+10, 80, 80);
    [pauseBtn setTitle:@"pause" forState:UIControlStateNormal];
    pauseBtn.backgroundColor = [UIColor grayColor];
    [pauseBtn addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton *seekBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    seekBtn.frame = CGRectMake(CGRectGetMaxX(pauseBtn.frame)+10, CGRectGetMaxY(_scan_btn.frame)+10, 80, 80);
    [seekBtn setTitle:@"seek" forState:UIControlStateNormal];
    seekBtn.backgroundColor = [UIColor grayColor];
    [seekBtn addTarget:self action:@selector(seek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seekBtn];
    
    UIButton *vPlusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    vPlusBtn.frame = CGRectMake(0, CGRectGetMaxY(playBtn.frame)+10, 80, 80);
    [vPlusBtn setTitle:@"V+" forState:UIControlStateNormal];
    vPlusBtn.backgroundColor = [UIColor grayColor];
    [vPlusBtn addTarget:self action:@selector(vPlus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vPlusBtn];
    
    UIButton *vMinusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    vMinusBtn.frame = CGRectMake(CGRectGetMaxX(vPlusBtn.frame)+10, CGRectGetMaxY(playBtn.frame)+10, 80, 80);
    [vMinusBtn setTitle:@"V-" forState:UIControlStateNormal];
    vMinusBtn.backgroundColor = [UIColor grayColor];
    [vMinusBtn addTarget:self action:@selector(vMinus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vMinusBtn];
    
    UIButton *getInfoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    getInfoBtn.frame = CGRectMake(CGRectGetMaxX(vMinusBtn.frame)+10, CGRectGetMaxY(playBtn.frame)+10, 80, 80);
    [getInfoBtn setTitle:@"getInfo" forState:UIControlStateNormal];
    getInfoBtn.backgroundColor = [UIColor grayColor];
    [getInfoBtn addTarget:self action:@selector(getInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getInfoBtn];
}

- (void) scan:(UIButton *)btn{
    m_is_scan = !m_is_scan;
    if (m_is_scan) {
        m_discovery -> scan( Discovery::MEDIA_RENDERER );
        [self.scan_btn setTitle:@"stop" forState:UIControlStateNormal];
        [self.test0 setText:@"Scaning..."];
    }else{
        m_discovery ->stop();
        [self.scan_btn setTitle:@"Scan" forState:UIControlStateNormal];
    }
}

#define CALL(exec) \
vector<Service*> ls = m_discovery->service( Discovery::MEDIA_RENDERER ); \
for (int i = 0; i < ls.size(); i++) { \
MediaRenderer* mr = ls[i]->as_media_renderer(); \
if ( mr ) { \
exec; \
} \
}

- (void) start:(UIButton *)btn{
    
    vector<Service*> ls = m_discovery->service( Discovery::MEDIA_RENDERER );
    for (int i = 0; i < ls.size(); i++) {
        MediaRenderer* mr = ls[i]->as_media_renderer();
        if ( mr ) {
            const char* name = mr->get_friendly_name().c_str();
            NSLog(@"%s",name);
            mr -> set_av_transport_uri("http://huace.cdn.ottcloud.tv/huace/videos/dst/2016/08/14461-ai-de-zhui-zong-01-ji_201608180551/14461-ai-de-zhui-zong-01-ji.m3u8");
//            https://manifest.googlevideo.com/api/manifest/hls_variant/upn/d-WyZxATzEU/signature/6978A1F587E4EFD0219C233BE8683FFBF82BF819.8D2939A83935128E63630E194D5C175D5B5D2552/sparams/ei%2Cgcr%2Cgo%2Chfr%2Cid%2Cip%2Cipbits%2Citag%2Cmaudio%2Cplaylist_type%2Cratebypass%2Crequiressl%2Csource%2Cexpire/id/zUnjf_W3GWQ.0/go/1/gcr/us/ratebypass/yes/playlist_type/DVR/ipbits/0/ei/TUokWJHwMMLH8gSa_5aQCQ/requiressl/yes/ip/45.55.84.189/key/yt6/maudio/1/keepalive/yes/itag/0/source/yt_live_broadcast/dover/6/hfr/1/expire/1478794925/file/index.m3u8
        }
    }

    
//    CALL({
//        mr -> set_av_transport_uri("http://huace.cdn.ottcloud.tv/huace/videos/dst/2016/08/14461-ai-de-zhui-zong-01-ji_201608180551/14461-ai-de-zhui-zong-01-ji.m3u8");
//    });
}

- (void) stop:(UIButton *)btn{
    CALL({
        mr -> stop();
    })
}

- (void) play:(UIButton *)btn{
    CALL({
        mr -> play();
    })
}

- (void) pause:(UIButton *)btn{
    CALL({
        mr -> pause();
    })
}

- (void) seek:(UIButton *)btn{
    CALL({
        mr -> seek(1000);
    })
}

- (void) vPlus:(UIButton *)btn{
    m_volume++;
    CALL({
        mr -> set_volume(m_volume);
    })
}

- (void) vMinus:(UIButton *)btn{
    m_volume--;
    CALL({
        mr -> set_volume(m_volume);
    })
}

- (void) getInfo:(UIButton *)btn{
    vector<Service*> ls = m_discovery->service( Discovery::MEDIA_RENDERER );
    NSString* data = [NSString string];
    
    for (int i = 0; i < ls.size(); i++) {
        MediaRenderer* mr = ls[i]->as_media_renderer();
        if ( mr ) {
            // Result res1 = m_discovery->mr()->get_media_info();
            Result res2 = mr->get_position_info();
            
            if ( res2.code == 0 ) {
                data = [data stringByAppendingFormat:@"##MediaDuration: %d, RelTime: %d, TrackURI: %s",
                        // res1.data["MediaDuration"].GetInt(),
                        res2.data["TrackDuration"].GetInt(),
                        res2.data["RelTime"].GetInt(),
                        res2.data["TrackURI"].GetString()
                        ];
            }
        }
    }
    
    [self.test1 setText:data];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    delete m_discovery;

    // Dispose of any resources that can be recreated.
}


@end
