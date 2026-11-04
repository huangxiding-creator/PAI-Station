.class Lcom/rokid/utils/ByteArrayPool$DEFAULT_HOLDER;
.super Ljava/lang/Object;
.source "ByteArrayPool.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/utils/ByteArrayPool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "DEFAULT_HOLDER"
.end annotation


# static fields
.field private static DEFAULT_POOL:Lcom/rokid/utils/ByteArrayPool;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 67
    new-instance v0, Lcom/rokid/utils/ByteArrayPool;

    const/high16 v1, 0x9600000

    invoke-direct {v0, v1}, Lcom/rokid/utils/ByteArrayPool;-><init>(I)V

    sput-object v0, Lcom/rokid/utils/ByteArrayPool$DEFAULT_HOLDER;->DEFAULT_POOL:Lcom/rokid/utils/ByteArrayPool;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 69
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 70
    return-void
.end method

.method static synthetic access$000()Lcom/rokid/utils/ByteArrayPool;
    .locals 1

    .line 66
    sget-object v0, Lcom/rokid/utils/ByteArrayPool$DEFAULT_HOLDER;->DEFAULT_POOL:Lcom/rokid/utils/ByteArrayPool;

    return-object v0
.end method
