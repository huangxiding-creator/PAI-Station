.class public Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "InitializeBuilder"
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# instance fields
.field private awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

.field private context:Landroid/content/Context;

.field private signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;


# direct methods
.method public constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;)V
    .locals 1
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3616
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3617
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->context:Landroid/content/Context;

    .line 3618
    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3619
    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    .line 3620
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Landroid/content/Context;)V
    .locals 1
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p2, "context"    # Landroid/content/Context;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3632
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3633
    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->context:Landroid/content/Context;

    .line 3634
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3635
    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    .line 3636
    return-void
.end method


# virtual methods
.method public awsConfiguration(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;
    .locals 0
    .param p1, "awsConfiguration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3649
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3650
    return-object p0
.end method

.method public execute()V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3715
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v0, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1500(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;)V

    .line 3716
    return-void
.end method

.method public getAwsConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3678
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    return-object v0
.end method

.method public getContext()Landroid/content/Context;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3704
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->context:Landroid/content/Context;

    return-object v0
.end method

.method public getSignInProviderConfig()[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3691
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    return-object v0
.end method

.method public varargs signInProviders([Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;)Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;
    .locals 0
    .param p1, "providersConfig"    # [Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3664
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    .line 3665
    return-object p0
.end method
