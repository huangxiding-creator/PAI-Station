.class public final enum Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;
.super Ljava/lang/Enum;
.source "DataType.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u0005\n\u0002\u0008\t\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008j\u0002\u0008\tj\u0002\u0008\nj\u0002\u0008\u000b\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;",
        "",
        "value",
        "",
        "(Ljava/lang/String;IB)V",
        "getValue",
        "()B",
        "TEXT_MESSAGE",
        "AUDIO_STREAM",
        "VIDEO_H264_STREAM",
        "FILE_DATA",
        "STREAM_DATA",
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


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

.field public static final enum AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

.field public static final enum FILE_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

.field public static final enum STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

.field public static final enum TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

.field public static final enum VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;


# instance fields
.field private final value:B


# direct methods
.method private static final synthetic $values()[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;
    .locals 5

    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->FILE_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    filled-new-array {v0, v1, v2, v3, v4}, [Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 4
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    const-string v1, "TEXT_MESSAGE"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;-><init>(Ljava/lang/String;IB)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    .line 5
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    const-string v1, "AUDIO_STREAM"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v3, v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;-><init>(Ljava/lang/String;IB)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    .line 6
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    const-string v1, "VIDEO_H264_STREAM"

    const/4 v3, 0x3

    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;-><init>(Ljava/lang/String;IB)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    .line 7
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    const-string v1, "FILE_DATA"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v3, v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;-><init>(Ljava/lang/String;IB)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->FILE_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    .line 8
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    const-string v1, "STREAM_DATA"

    const/4 v3, 0x5

    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;-><init>(Ljava/lang/String;IB)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-static {}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->$values()[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->$VALUES:[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;IB)V
    .locals 0
    .param p1, "$enum$name"    # Ljava/lang/String;
    .param p2, "$enum$ordinal"    # I
    .param p3, "value"    # B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(B)V"
        }
    .end annotation

    .line 3
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-byte p3, p0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->value:B

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;
    .locals 1

    const-class v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;
    .locals 1

    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->$VALUES:[Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    return-object v0
.end method


# virtual methods
.method public final getValue()B
    .locals 1

    .line 3
    iget-byte v0, p0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->value:B

    return v0
.end method
