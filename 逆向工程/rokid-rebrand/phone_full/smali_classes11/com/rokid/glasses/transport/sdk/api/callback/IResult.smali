.class public final Lcom/rokid/glasses/transport/sdk/api/callback/IResult;
.super Ljava/lang/Object;
.source "IResult.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;,
        Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0000\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0008\u0087@\u0018\u0000  *\u0006\u0008\u0000\u0010\u0001 \u00012\u00020\u0002:\u0002 !B\u0016\u0008\u0001\u0012\u0008\u0010\u0003\u001a\u0004\u0018\u00010\u0002\u00f8\u0001\u0000\u00a2\u0006\u0004\u0008\u0004\u0010\u0005J\u001a\u0010\u000e\u001a\u00020\u00072\u0008\u0010\u000f\u001a\u0004\u0018\u00010\u0002H\u00d6\u0003\u00a2\u0006\u0004\u0008\u0010\u0010\u0011J\u000f\u0010\u0012\u001a\u0004\u0018\u00010\u0013\u00a2\u0006\u0004\u0008\u0014\u0010\u0015J\u0012\u0010\u0016\u001a\u0004\u0018\u00018\u0000H\u0086\u0008\u00a2\u0006\u0004\u0008\u0017\u0010\u0005J\u0010\u0010\u0018\u001a\u00020\u0019H\u00d6\u0001\u00a2\u0006\u0004\u0008\u001a\u0010\u001bJ\u000f\u0010\u001c\u001a\u00020\u001dH\u0016\u00a2\u0006\u0004\u0008\u001e\u0010\u001fR\u0011\u0010\u0006\u001a\u00020\u00078F\u00a2\u0006\u0006\u001a\u0004\u0008\u0008\u0010\tR\u0011\u0010\n\u001a\u00020\u00078F\u00a2\u0006\u0006\u001a\u0004\u0008\u000b\u0010\tR\u0013\u0010\u0003\u001a\u0004\u0018\u00010\u0002\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\r\u0088\u0001\u0003\u00f8\u0001\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\""
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "T",
        "",
        "value",
        "constructor-impl",
        "(Ljava/lang/Object;)Ljava/lang/Object;",
        "isFailure",
        "",
        "isFailure-impl",
        "(Ljava/lang/Object;)Z",
        "isSuccess",
        "isSuccess-impl",
        "getValue",
        "()Ljava/lang/Object;",
        "equals",
        "other",
        "equals-impl",
        "(Ljava/lang/Object;Ljava/lang/Object;)Z",
        "exceptionOrNull",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "exceptionOrNull-impl",
        "(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "getOrNull",
        "getOrNull-impl",
        "hashCode",
        "",
        "hashCode-impl",
        "(Ljava/lang/Object;)I",
        "toString",
        "",
        "toString-impl",
        "(Ljava/lang/Object;)Ljava/lang/String;",
        "Companion",
        "Failure",
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

.annotation runtime Lkotlin/jvm/JvmInline;
.end annotation


# static fields
.field public static final Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;


# instance fields
.field private final value:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    return-void
.end method

.method private synthetic constructor <init>(Ljava/lang/Object;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/Object;

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    return-void
.end method

.method public static final synthetic box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method

.method public static constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    return-object p0
.end method

.method public static equals-impl(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 2

    instance-of v0, p1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    move-object v0, p1

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method public static final equals-impl0(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 1

    invoke-static {p0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static final exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .locals 1
    .param p0, "arg0"    # Ljava/lang/Object;

    .line 54
    nop

    .line 55
    instance-of v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    iget-object v0, v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    goto :goto_0

    .line 56
    :cond_0
    const/4 v0, 0x0

    .line 57
    :goto_0
    return-object v0
.end method

.method public static final getOrNull-impl(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p0, "arg0"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 42
    .local v0, "$i$f$getOrNull-impl":I
    nop

    .line 43
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    .line 44
    :cond_0
    move-object v1, p0

    .line 45
    :goto_0
    return-object v1
.end method

.method public static hashCode-impl(Ljava/lang/Object;)I
    .locals 1

    if-nez p0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    :goto_0
    return v0
.end method

.method public static final isFailure-impl(Ljava/lang/Object;)Z
    .locals 1
    .param p0, "arg0"    # Ljava/lang/Object;

    .line 29
    instance-of v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    return v0
.end method

.method public static final isSuccess-impl(Ljava/lang/Object;)Z
    .locals 1
    .param p0, "arg0"    # Ljava/lang/Object;

    .line 23
    instance-of v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static toString-impl(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2
    .param p0, "arg0"    # Ljava/lang/Object;

    .line 65
    nop

    .line 66
    instance-of v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 67
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Success("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 68
    :goto_0
    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->equals-impl(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final getValue()Ljava/lang/Object;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->hashCode-impl(Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->toString-impl(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 68
    return-object v0
.end method

.method public final synthetic unbox-impl()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->value:Ljava/lang/Object;

    return-object v0
.end method
