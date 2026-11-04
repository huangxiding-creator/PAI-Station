.class public final Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
.super Ljava/lang/Object;
.source "IResult.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/callback/IResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J%\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u0002H\u00050\u0004\"\u0004\u0008\u0001\u0010\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0087\u0008\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0008J\'\u0010\t\u001a\u0008\u0012\u0004\u0012\u0002H\u00050\u0004\"\u0004\u0008\u0001\u0010\u00052\u0008\u0010\n\u001a\u0004\u0018\u0001H\u0005H\u0087\u0008\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u000b\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;",
        "",
        "()V",
        "failure",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "T",
        "exception",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;",
        "success",
        "value",
        "(Ljava/lang/Object;)Ljava/lang/Object;",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final failure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 2
    .param p1, "exception"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "exception"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 93
    .local v0, "$i$f$failure":I
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    return-object v1
.end method

.method public final success(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "value"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 84
    .local v0, "$i$f$success":I
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    return-object v1
.end method
