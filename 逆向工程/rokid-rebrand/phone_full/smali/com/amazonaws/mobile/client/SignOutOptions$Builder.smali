.class public Lcom/amazonaws/mobile/client/SignOutOptions$Builder;
.super Ljava/lang/Object;
.source "SignOutOptions.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/mobile/client/SignOutOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private browserPackage:Ljava/lang/String;

.field private invalidateTokens:Z

.field private signOutGlobally:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/client/SignOutOptions$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignOutOptions$Builder;

    .line 33
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->signOutGlobally:Z

    return v0
.end method

.method static synthetic access$100(Lcom/amazonaws/mobile/client/SignOutOptions$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignOutOptions$Builder;

    .line 33
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->invalidateTokens:Z

    return v0
.end method

.method static synthetic access$200(Lcom/amazonaws/mobile/client/SignOutOptions$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/SignOutOptions$Builder;

    .line 33
    iget-object v0, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->browserPackage:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public browserPackage(Ljava/lang/String;)Lcom/amazonaws/mobile/client/SignOutOptions$Builder;
    .locals 0
    .param p1, "browserPackage"    # Ljava/lang/String;

    .line 60
    iput-object p1, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->browserPackage:Ljava/lang/String;

    .line 61
    return-object p0
.end method

.method public build()Lcom/amazonaws/mobile/client/SignOutOptions;
    .locals 1

    .line 82
    new-instance v0, Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/SignOutOptions;-><init>(Lcom/amazonaws/mobile/client/SignOutOptions$Builder;)V

    return-object v0
.end method

.method public invalidateTokens(Z)Lcom/amazonaws/mobile/client/SignOutOptions$Builder;
    .locals 0
    .param p1, "invalidateTokens"    # Z

    .line 72
    iput-boolean p1, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->invalidateTokens:Z

    .line 73
    return-object p0
.end method

.method public signOutGlobally(Z)Lcom/amazonaws/mobile/client/SignOutOptions$Builder;
    .locals 0
    .param p1, "signOutGlobally"    # Z

    .line 48
    iput-boolean p1, p0, Lcom/amazonaws/mobile/client/SignOutOptions$Builder;->signOutGlobally:Z

    .line 49
    return-object p0
.end method
