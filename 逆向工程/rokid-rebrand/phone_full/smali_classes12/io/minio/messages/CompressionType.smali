.class public final enum Lio/minio/messages/CompressionType;
.super Ljava/lang/Enum;
.source "CompressionType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/CompressionType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/CompressionType;

.field public static final enum BZIP2:Lio/minio/messages/CompressionType;

.field public static final enum GZIP:Lio/minio/messages/CompressionType;

.field public static final enum NONE:Lio/minio/messages/CompressionType;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/CompressionType;
    .locals 3

    .line 20
    sget-object v0, Lio/minio/messages/CompressionType;->NONE:Lio/minio/messages/CompressionType;

    sget-object v1, Lio/minio/messages/CompressionType;->GZIP:Lio/minio/messages/CompressionType;

    sget-object v2, Lio/minio/messages/CompressionType;->BZIP2:Lio/minio/messages/CompressionType;

    filled-new-array {v0, v1, v2}, [Lio/minio/messages/CompressionType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 21
    new-instance v0, Lio/minio/messages/CompressionType;

    const-string v1, "NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/messages/CompressionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/CompressionType;->NONE:Lio/minio/messages/CompressionType;

    .line 22
    new-instance v0, Lio/minio/messages/CompressionType;

    const-string v1, "GZIP"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/messages/CompressionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/CompressionType;->GZIP:Lio/minio/messages/CompressionType;

    .line 23
    new-instance v0, Lio/minio/messages/CompressionType;

    const-string v1, "BZIP2"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/minio/messages/CompressionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/CompressionType;->BZIP2:Lio/minio/messages/CompressionType;

    .line 20
    invoke-static {}, Lio/minio/messages/CompressionType;->$values()[Lio/minio/messages/CompressionType;

    move-result-object v0

    sput-object v0, Lio/minio/messages/CompressionType;->$VALUES:[Lio/minio/messages/CompressionType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/CompressionType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lio/minio/messages/CompressionType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/CompressionType;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/CompressionType;
    .locals 1

    .line 20
    sget-object v0, Lio/minio/messages/CompressionType;->$VALUES:[Lio/minio/messages/CompressionType;

    invoke-virtual {v0}, [Lio/minio/messages/CompressionType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/CompressionType;

    return-object v0
.end method
