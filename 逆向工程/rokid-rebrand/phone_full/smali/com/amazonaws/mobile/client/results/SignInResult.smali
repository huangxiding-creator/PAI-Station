.class public Lcom/amazonaws/mobile/client/results/SignInResult;
.super Ljava/lang/Object;
.source "SignInResult.java"


# static fields
.field public static final DONE:Lcom/amazonaws/mobile/client/results/SignInResult;


# instance fields
.field private final codeDetails:Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

.field private final parameters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final signInState:Lcom/amazonaws/mobile/client/results/SignInState;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 30
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInResult;

    sget-object v1, Lcom/amazonaws/mobile/client/results/SignInState;->DONE:Lcom/amazonaws/mobile/client/results/SignInState;

    invoke-direct {v0, v1}, Lcom/amazonaws/mobile/client/results/SignInResult;-><init>(Lcom/amazonaws/mobile/client/results/SignInState;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInResult;->DONE:Lcom/amazonaws/mobile/client/results/SignInResult;

    return-void
.end method

.method private constructor <init>(Lcom/amazonaws/mobile/client/results/SignInState;)V
    .locals 1
    .param p1, "signInState"    # Lcom/amazonaws/mobile/client/results/SignInState;

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 34
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->parameters:Ljava/util/Map;

    .line 35
    iput-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->codeDetails:Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 36
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/mobile/client/results/SignInState;Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;)V
    .locals 1
    .param p1, "signInState"    # Lcom/amazonaws/mobile/client/results/SignInState;
    .param p2, "codeDetails"    # Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput-object p1, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 46
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->parameters:Ljava/util/Map;

    .line 47
    iput-object p2, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->codeDetails:Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 48
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/mobile/client/results/SignInState;Ljava/util/Map;)V
    .locals 1
    .param p1, "signInState"    # Lcom/amazonaws/mobile/client/results/SignInState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/results/SignInState;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 38
    .local p2, "parameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 40
    iput-object p2, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->parameters:Ljava/util/Map;

    .line 41
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->codeDetails:Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 42
    return-void
.end method


# virtual methods
.method public getCodeDetails()Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    .locals 1

    .line 68
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->codeDetails:Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    return-object v0
.end method

.method public getParameters()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 60
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->parameters:Ljava/util/Map;

    return-object v0
.end method

.method public getSignInState()Lcom/amazonaws/mobile/client/results/SignInState;
    .locals 1

    .line 51
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInResult;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    return-object v0
.end method
