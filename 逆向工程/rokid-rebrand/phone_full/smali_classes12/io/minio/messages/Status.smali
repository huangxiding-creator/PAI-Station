.class public final enum Lio/minio/messages/Status;
.super Ljava/lang/Enum;
.source "Status.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/Status$StatusConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/Status;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Status"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/Status$StatusConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/Status;

.field public static final enum DISABLED:Lio/minio/messages/Status;

.field public static final enum ENABLED:Lio/minio/messages/Status;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/Status;
    .locals 2

    .line 28
    sget-object v0, Lio/minio/messages/Status;->DISABLED:Lio/minio/messages/Status;

    sget-object v1, Lio/minio/messages/Status;->ENABLED:Lio/minio/messages/Status;

    filled-new-array {v0, v1}, [Lio/minio/messages/Status;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 31
    new-instance v0, Lio/minio/messages/Status;

    const/4 v1, 0x0

    const-string v2, "Disabled"

    const-string v3, "DISABLED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/Status;->DISABLED:Lio/minio/messages/Status;

    .line 32
    new-instance v0, Lio/minio/messages/Status;

    const/4 v1, 0x1

    const-string v2, "Enabled"

    const-string v3, "ENABLED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/Status;->ENABLED:Lio/minio/messages/Status;

    .line 28
    invoke-static {}, Lio/minio/messages/Status;->$values()[Lio/minio/messages/Status;

    move-result-object v0

    sput-object v0, Lio/minio/messages/Status;->$VALUES:[Lio/minio/messages/Status;

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
    iput-object p3, p0, Lio/minio/messages/Status;->value:Ljava/lang/String;

    .line 38
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/Status;
    .locals 5
    .param p0, "statusString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 47
    invoke-static {}, Lio/minio/messages/Status;->values()[Lio/minio/messages/Status;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 48
    .local v3, "status":Lio/minio/messages/Status;
    iget-object v4, v3, Lio/minio/messages/Status;->value:Ljava/lang/String;

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 49
    return-object v3

    .line 47
    .end local v3    # "status":Lio/minio/messages/Status;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 53
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown status \'"

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

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/Status;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 28
    const-class v0, Lio/minio/messages/Status;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/Status;
    .locals 1

    .line 28
    sget-object v0, Lio/minio/messages/Status;->$VALUES:[Lio/minio/messages/Status;

    invoke-virtual {v0}, [Lio/minio/messages/Status;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/Status;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lio/minio/messages/Status;->value:Ljava/lang/String;

    return-object v0
.end method
