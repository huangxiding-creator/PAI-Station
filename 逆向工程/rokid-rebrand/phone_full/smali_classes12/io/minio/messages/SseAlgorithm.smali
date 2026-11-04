.class public final enum Lio/minio/messages/SseAlgorithm;
.super Ljava/lang/Enum;
.source "SseAlgorithm.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/SseAlgorithm$SseAlgorithmConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/SseAlgorithm;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "SSEAlgorithm"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/SseAlgorithm$SseAlgorithmConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/SseAlgorithm;

.field public static final enum AES256:Lio/minio/messages/SseAlgorithm;

.field public static final enum AWS_KMS:Lio/minio/messages/SseAlgorithm;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/SseAlgorithm;
    .locals 2

    .line 28
    sget-object v0, Lio/minio/messages/SseAlgorithm;->AES256:Lio/minio/messages/SseAlgorithm;

    sget-object v1, Lio/minio/messages/SseAlgorithm;->AWS_KMS:Lio/minio/messages/SseAlgorithm;

    filled-new-array {v0, v1}, [Lio/minio/messages/SseAlgorithm;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 31
    new-instance v0, Lio/minio/messages/SseAlgorithm;

    const-string v1, "AES256"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1}, Lio/minio/messages/SseAlgorithm;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/SseAlgorithm;->AES256:Lio/minio/messages/SseAlgorithm;

    .line 32
    new-instance v0, Lio/minio/messages/SseAlgorithm;

    const/4 v1, 0x1

    const-string v2, "aws:kms"

    const-string v3, "AWS_KMS"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/SseAlgorithm;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/SseAlgorithm;->AWS_KMS:Lio/minio/messages/SseAlgorithm;

    .line 28
    invoke-static {}, Lio/minio/messages/SseAlgorithm;->$values()[Lio/minio/messages/SseAlgorithm;

    move-result-object v0

    sput-object v0, Lio/minio/messages/SseAlgorithm;->$VALUES:[Lio/minio/messages/SseAlgorithm;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 36
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 37
    iput-object p3, p0, Lio/minio/messages/SseAlgorithm;->value:Ljava/lang/String;

    .line 38
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/SseAlgorithm;
    .locals 5
    .param p0, "sseAlgorithmString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 47
    invoke-static {}, Lio/minio/messages/SseAlgorithm;->values()[Lio/minio/messages/SseAlgorithm;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 48
    .local v3, "sa":Lio/minio/messages/SseAlgorithm;
    iget-object v4, v3, Lio/minio/messages/SseAlgorithm;->value:Ljava/lang/String;

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 49
    return-object v3

    .line 47
    .end local v3    # "sa":Lio/minio/messages/SseAlgorithm;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 53
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "unknown SSE algorithm \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/SseAlgorithm;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 28
    const-class v0, Lio/minio/messages/SseAlgorithm;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/SseAlgorithm;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/SseAlgorithm;
    .locals 1

    .line 28
    sget-object v0, Lio/minio/messages/SseAlgorithm;->$VALUES:[Lio/minio/messages/SseAlgorithm;

    invoke-virtual {v0}, [Lio/minio/messages/SseAlgorithm;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/SseAlgorithm;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lio/minio/messages/SseAlgorithm;->value:Ljava/lang/String;

    return-object v0
.end method
