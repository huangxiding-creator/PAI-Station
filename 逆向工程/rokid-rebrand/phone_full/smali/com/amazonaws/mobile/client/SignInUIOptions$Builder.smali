.class public Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
.super Ljava/lang/Object;
.source "SignInUIOptions.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/mobile/client/SignInUIOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private backgroundColor:Ljava/lang/Integer;

.field private browserPackage:Ljava/lang/String;

.field private canCancel:Z

.field private hostedUIOptions:Lcom/amazonaws/mobile/client/HostedUIOptions;

.field private logo:Ljava/lang/Integer;

.field private nextActivityClass:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "+",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->browserPackage:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Ljava/lang/Integer;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->logo:Ljava/lang/Integer;

    return-object v0
.end method

.method static synthetic access$200(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Ljava/lang/Integer;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->backgroundColor:Ljava/lang/Integer;

    return-object v0
.end method

.method static synthetic access$300(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->canCancel:Z

    return v0
.end method

.method static synthetic access$400(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Ljava/lang/Class;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->nextActivityClass:Ljava/lang/Class;

    return-object v0
.end method

.method static synthetic access$500(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)Lcom/amazonaws/mobile/client/HostedUIOptions;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->hostedUIOptions:Lcom/amazonaws/mobile/client/HostedUIOptions;

    return-object v0
.end method


# virtual methods
.method public backgroundColor(Ljava/lang/Integer;)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .param p1, "logoResourceId"    # Ljava/lang/Integer;

    .line 70
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->backgroundColor:Ljava/lang/Integer;

    .line 71
    return-object p0
.end method

.method public browserPackage(Ljava/lang/String;)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .param p1, "browserPackage"    # Ljava/lang/String;

    .line 65
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->browserPackage:Ljava/lang/String;

    .line 66
    return-object p0
.end method

.method public build()Lcom/amazonaws/mobile/client/SignInUIOptions;
    .locals 1

    .line 90
    new-instance v0, Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/SignInUIOptions;-><init>(Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;)V

    return-object v0
.end method

.method public canCancel(Z)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .param p1, "canCancel"    # Z

    .line 75
    iput-boolean p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->canCancel:Z

    .line 76
    return-object p0
.end method

.method public hostedUIOptions(Lcom/amazonaws/mobile/client/HostedUIOptions;)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .param p1, "hostedUIOptions"    # Lcom/amazonaws/mobile/client/HostedUIOptions;

    .line 85
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->hostedUIOptions:Lcom/amazonaws/mobile/client/HostedUIOptions;

    .line 86
    return-object p0
.end method

.method public logo(Ljava/lang/Integer;)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .param p1, "logoResourceId"    # Ljava/lang/Integer;

    .line 54
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->logo:Ljava/lang/Integer;

    .line 55
    return-object p0
.end method

.method public nextActivity(Ljava/lang/Class;)Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Landroid/app/Activity;",
            ">;)",
            "Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;"
        }
    .end annotation

    .line 80
    .local p1, "nextActivityClass":Ljava/lang/Class;, "Ljava/lang/Class<+Landroid/app/Activity;>;"
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->nextActivityClass:Ljava/lang/Class;

    .line 81
    return-object p0
.end method
