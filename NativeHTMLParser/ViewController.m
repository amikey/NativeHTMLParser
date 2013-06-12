//
//  ViewController.m
//  NativeHTMLParser
//
//  Created by Reza Fatahi on 6/11/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSURL* yourURL = [NSURL URLWithString: @"http://www.toysrus.com/product/index.jsp?productId=20405306"];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:yourURL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               NSLog(@"htmlString\n%@", htmlString);
                               
                               
                               //PRICE
                               //
                               NSString *startTag = @"<li class=\"retail\">";
                               NSString *endTag = @"</li>";
                               
                               NSString *priceString = nil;
                               
                               NSScanner *scanner = [[NSScanner alloc] initWithString:htmlString];
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&priceString];

                               
                               scanner = [[NSScanner alloc] initWithString:priceString];
                               startTag = @"&#036;";
                               endTag = @"</span>";
                               
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&priceString];
                               
                               NSLog(@"%@", priceString);
 
                               
                               //NAME
                               //
                               NSString *nameString = nil;
                               
                               scanner = [[NSScanner alloc] initWithString:htmlString];
                               startTag = @"<div id=\"priceReviewAge\">";
                               endTag = @"<h3>";
                               
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&nameString
                                ];
                               
                               
                               scanner = [[NSScanner alloc] initWithString:nameString];
                               startTag = @"<h1>";
                               endTag = @"</h1>";
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&nameString];
                               
                               NSLog(@"name string is %@", nameString);


                               //DESCRIPTION
                               //
                               NSString *descriptionString = nil;
                               
                               scanner = [[NSScanner alloc] initWithString:htmlString];
                               startTag = @"<label>Product Description</label>";
                               endTag = @"<p>";
                               
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&descriptionString
                                ];
                               
                               
                               startTag = @"<br />";
                               endTag = @"<br />";
                               
                               scanner = [[NSScanner alloc] initWithString:descriptionString];
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&descriptionString
                                ];
                               
                               NSLog(@"%@", descriptionString);
                               
                               
                               //IMAGE
                               //
                               NSString *imageString = nil;
                               
                               scanner = [[NSScanner alloc] initWithString:htmlString];
                               startTag = @"dtmTag.dtmc_prod_img =";
                               endTag = @";";
                               
                               [scanner scanUpToString:startTag intoString:nil];
                               scanner.scanLocation += [startTag length];
                               [scanner scanUpToString:endTag intoString:&imageString
                                ];
                               
                               NSLog(@"%@", imageString);
     
                               
                           }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
