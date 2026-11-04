.class public final enum Lio/minio/messages/CannedAcl;
.super Ljava/lang/Enum;
.source "CannedAcl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/CannedAcl$CannedAclConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/CannedAcl;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CannedAcl"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/CannedAcl$CannedAclConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/CannedAcl;

.field public static final enum AUTHENTICATED_READ:Lio/minio/messages/CannedAcl;

.field public static final enum AWS_EXEC_READ:Lio/minio/messages/CannedAcl;

.field public static final enum BUCKET_OWNER_FULL_CONTROL:Lio/minio/messages/CannedAcl;

.field public static final enum BUCKET_OWNER_READ:Lio/minio/messages/CannedAcl;

.field public static final enum PRIVATE:Lio/minio/messages/CannedAcl;

.field public static final enum PUBLIC_READ:Lio/minio/messages/CannedAcl;

.field public static final enum PUBLIC_READ_WRITE:Lio/minio/messages/CannedAcl;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/CannedAcl;
    .locals 7

    .line 27
    sget-object v0, Lio/minio/messages/CannedAcl;->PRIVATE:Lio/minio/messages/CannedAcl;

    sget-object v1, Lio/minio/messages/CannedAcl;->PUBLIC_READ:Lio/minio/messages/CannedAcl;

    sget-object v2, Lio/minio/messages/CannedAcl;->PUBLIC_READ_WRITE:Lio/minio/messages/CannedAcl;

    sget-object v3, Lio/minio/messages/CannedAcl;->AUTHENTICATED_READ:Lio/minio/messages/CannedAcl;

    sget-object v4, Lio/minio/messages/CannedAcl;->AWS_EXEC_READ:Lio/minio/messages/CannedAcl;

    sget-object v5, Lio/minio/messages/CannedAcl;->BUCKET_OWNER_READ:Lio/minio/messages/CannedAcl;

    sget-object v6, Lio/minio/messages/CannedAcl;->BUCKET_OWNER_FULL_CONTROL:Lio/minio/messages/CannedAcl;

    filled-new-array/range {v0 .. v6}, [Lio/minio/messages/CannedAcl;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 30
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x0

    const-string v2, "private"

    const-string v3, "PRIVATE"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->PRIVATE:Lio/minio/messages/CannedAcl;

    .line 31
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x1

    const-string v2, "public-read"

    const-string v3, "PUBLIC_READ"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->PUBLIC_READ:Lio/minio/messages/CannedAcl;

    .line 32
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x2

    const-string v2, "public-read-write"

    const-string v3, "PUBLIC_READ_WRITE"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->PUBLIC_READ_WRITE:Lio/minio/messages/CannedAcl;

    .line 33
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x3

    const-string v2, "authenticated-read"

    const-string v3, "AUTHENTICATED_READ"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->AUTHENTICATED_READ:Lio/minio/messages/CannedAcl;

    .line 34
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x4

    const-string v2, "aws-exec-read"

    const-string v3, "AWS_EXEC_READ"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->AWS_EXEC_READ:Lio/minio/messages/CannedAcl;

    .line 35
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x5

    const-string v2, "bucket-owner-read"

    const-string v3, "BUCKET_OWNER_READ"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->BUCKET_OWNER_READ:Lio/minio/messages/CannedAcl;

    .line 36
    new-instance v0, Lio/minio/messages/CannedAcl;

    const/4 v1, 0x6

    const-string v2, "bucket-owner-full-control"

    const-string v3, "BUCKET_OWNER_FULL_CONTROL"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/CannedAcl;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/CannedAcl;->BUCKET_OWNER_FULL_CONTROL:Lio/minio/messages/CannedAcl;

    .line 27
    invoke-static {}, Lio/minio/messages/CannedAcl;->$values()[Lio/minio/messages/CannedAcl;

    move-result-object v0

    sput-object v0, Lio/minio/messages/CannedAcl;->$VALUES:[Lio/minio/messages/CannedAcl;

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

    .line 40
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 41
    iput-object p3, p0, Lio/minio/messages/CannedAcl;->value:Ljava/lang/String;

    .line 42
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/CannedAcl;
    .locals 5
    .param p0, "cannedAclString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 51
    invoke-static {}, Lio/minio/messages/CannedAcl;->values()[Lio/minio/messages/CannedAcl;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 52
    .local v3, "cannedAcl":Lio/minio/messages/CannedAcl;
    iget-object v4, v3, Lio/minio/messages/CannedAcl;->value:Ljava/lang/String;

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 53
    return-object v3

    .line 51
    .end local v3    # "cannedAcl":Lio/minio/messages/CannedAcl;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 57
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown canned ACL \'"

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

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/CannedAcl;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 27
    const-class v0, Lio/minio/messages/CannedAcl;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/CannedAcl;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/CannedAcl;
    .locals 1

    .line 27
    sget-object v0, Lio/minio/messages/CannedAcl;->$VALUES:[Lio/minio/messages/CannedAcl;

    invoke-virtual {v0}, [Lio/minio/messages/CannedAcl;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/CannedAcl;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 45
    iget-object v0, p0, Lio/minio/messages/CannedAcl;->value:Ljava/lang/String;

    return-object v0
.end method
