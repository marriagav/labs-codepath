//
//  LoginViewController.m
//  parse-chat
//
//  Created by Miguel Arriaga Velasco on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UsernameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *PasswordOutlet;

@end

@implementation LoginViewController

- (IBAction)registerUser:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.UsernameOutlet.text;
//    newUser.email = self.emailField.text;
    newUser.password = self.PasswordOutlet.text;
    
    [self initializeAlertController];
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.UsernameOutlet.text;
    NSString *password = self.PasswordOutlet.text;
    [self initializeAlertController];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
      if (error != nil) {
          NSLog(@"User log in failed: %@", error.localizedDescription);
      } else {
          NSLog(@"User logged in successfully");
          
          [self performSegueWithIdentifier:@"loginSegue" sender:nil];
      }
    }];
}

- (void)initializeAlertController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                            message:@"Empty Field"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];

//    // create an OK action
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
//                                                       style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction * _Nonnull action) {
//                                                             // handle response here.
//                                                     }];
//    // add the OK action to the alert controller
//    [alert addAction:okAction];
//
    if ([self.UsernameOutlet.text isEqual:@""] || [self.PasswordOutlet.text isEqual:@""]){
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
