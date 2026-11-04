.class final Lcom/google/common/base/Java8Usage;
.super Ljava/lang/Object;
.source "Java8Usage.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/common/base/Java8Usage$SomeTypeAnnotation;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic lambda$performCheck$0()V
    .locals 0

    .line 39
    return-void
.end method

.method static performCheck()Ljava/lang/String;
    .locals 2

    .line 39
    new-instance v0, Lcom/google/common/base/Java8Usage$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/google/common/base/Java8Usage$$ExternalSyntheticLambda0;-><init>()V

    .line 40
    .local v0, "r":Ljava/lang/Runnable;
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 41
    const-string v1, ""

    return-object v1
.end method
