.class Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$DEFAULT_HOLDER;
.super Ljava/lang/Object;
.source "ByteArrayPool.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "DEFAULT_HOLDER"
.end annotation


# static fields
.field private static DEFAULT_POOL:Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 68
    new-instance v0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;

    const/high16 v1, 0x500000

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;-><init>(I)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$DEFAULT_HOLDER;->DEFAULT_POOL:Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    return-void
.end method

.method static synthetic access$000()Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
    .locals 1

    .line 67
    sget-object v0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$DEFAULT_HOLDER;->DEFAULT_POOL:Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;

    return-object v0
.end method
