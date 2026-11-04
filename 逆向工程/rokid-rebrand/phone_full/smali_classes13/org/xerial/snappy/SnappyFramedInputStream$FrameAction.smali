.class final enum Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;
.super Ljava/lang/Enum;
.source "SnappyFramedInputStream.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xerial/snappy/SnappyFramedInputStream;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "FrameAction"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

.field public static final enum RAW:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

.field public static final enum SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

.field public static final enum UNCOMPRESS:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 470
    new-instance v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    const-string v1, "RAW"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->RAW:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    new-instance v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    const-string v1, "SKIP"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    new-instance v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    const-string v1, "UNCOMPRESS"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->UNCOMPRESS:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    .line 468
    sget-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->RAW:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    sget-object v1, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    sget-object v2, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->UNCOMPRESS:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    filled-new-array {v0, v1, v2}, [Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    move-result-object v0

    sput-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->$VALUES:[Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 468
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;
    .locals 1

    .line 468
    const-class v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    return-object p0
.end method

.method public static values()[Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;
    .locals 1

    .line 468
    sget-object v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->$VALUES:[Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    invoke-virtual {v0}, [Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    return-object v0
.end method
