.class public final Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;
.super Ljava/lang/Object;
.source "IResult.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/callback/IResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Failure"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u0000\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0013\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0001H\u0096\u0002J\u0008\u0010\u0008\u001a\u00020\tH\u0016J\u0008\u0010\n\u001a\u00020\u000bH\u0016R\u0010\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;",
        "",
        "exception",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)V",
        "equals",
        "",
        "other",
        "hashCode",
        "",
        "toString",
        "",
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


# instance fields
.field public final exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;


# direct methods
.method public constructor <init>(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)V
    .locals 1
    .param p1, "exception"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const-string v0, "exception"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 97
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    .line 96
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 2
    .param p1, "other"    # Ljava/lang/Object;

    .line 100
    instance-of v0, p1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-object v1, p1

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    iget-object v1, v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 101
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 102
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Failure("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
