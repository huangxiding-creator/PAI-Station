.class public final enum Lio/minio/messages/EventType;
.super Ljava/lang/Enum;
.source "EventType.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/EventType$EventTypeConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/EventType;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Event"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/EventType$EventTypeConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/EventType;

.field public static final enum BUCKET_CREATED:Lio/minio/messages/EventType;

.field public static final enum BUCKET_REMOVED:Lio/minio/messages/EventType;

.field public static final enum OBJECT_ACCESSED_ANY:Lio/minio/messages/EventType;

.field public static final enum OBJECT_ACCESSED_GET:Lio/minio/messages/EventType;

.field public static final enum OBJECT_ACCESSED_HEAD:Lio/minio/messages/EventType;

.field public static final enum OBJECT_CREATED_ANY:Lio/minio/messages/EventType;

.field public static final enum OBJECT_CREATED_COMPLETE_MULTIPART_UPLOAD:Lio/minio/messages/EventType;

.field public static final enum OBJECT_CREATED_COPY:Lio/minio/messages/EventType;

.field public static final enum OBJECT_CREATED_POST:Lio/minio/messages/EventType;

.field public static final enum OBJECT_CREATED_PUT:Lio/minio/messages/EventType;

.field public static final enum OBJECT_REMOVED_ANY:Lio/minio/messages/EventType;

.field public static final enum OBJECT_REMOVED_DELETE:Lio/minio/messages/EventType;

.field public static final enum OBJECT_REMOVED_DELETED_MARKER_CREATED:Lio/minio/messages/EventType;

.field public static final enum REDUCED_REDUNDANCY_LOST_OBJECT:Lio/minio/messages/EventType;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/EventType;
    .locals 14

    .line 28
    sget-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_ANY:Lio/minio/messages/EventType;

    sget-object v1, Lio/minio/messages/EventType;->OBJECT_CREATED_PUT:Lio/minio/messages/EventType;

    sget-object v2, Lio/minio/messages/EventType;->OBJECT_CREATED_POST:Lio/minio/messages/EventType;

    sget-object v3, Lio/minio/messages/EventType;->OBJECT_CREATED_COPY:Lio/minio/messages/EventType;

    sget-object v4, Lio/minio/messages/EventType;->OBJECT_CREATED_COMPLETE_MULTIPART_UPLOAD:Lio/minio/messages/EventType;

    sget-object v5, Lio/minio/messages/EventType;->OBJECT_ACCESSED_GET:Lio/minio/messages/EventType;

    sget-object v6, Lio/minio/messages/EventType;->OBJECT_ACCESSED_HEAD:Lio/minio/messages/EventType;

    sget-object v7, Lio/minio/messages/EventType;->OBJECT_ACCESSED_ANY:Lio/minio/messages/EventType;

    sget-object v8, Lio/minio/messages/EventType;->OBJECT_REMOVED_ANY:Lio/minio/messages/EventType;

    sget-object v9, Lio/minio/messages/EventType;->OBJECT_REMOVED_DELETE:Lio/minio/messages/EventType;

    sget-object v10, Lio/minio/messages/EventType;->OBJECT_REMOVED_DELETED_MARKER_CREATED:Lio/minio/messages/EventType;

    sget-object v11, Lio/minio/messages/EventType;->REDUCED_REDUNDANCY_LOST_OBJECT:Lio/minio/messages/EventType;

    sget-object v12, Lio/minio/messages/EventType;->BUCKET_CREATED:Lio/minio/messages/EventType;

    sget-object v13, Lio/minio/messages/EventType;->BUCKET_REMOVED:Lio/minio/messages/EventType;

    filled-new-array/range {v0 .. v13}, [Lio/minio/messages/EventType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 31
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x0

    const-string/jumbo v2, "s3:ObjectCreated:*"

    const-string v3, "OBJECT_CREATED_ANY"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_ANY:Lio/minio/messages/EventType;

    .line 32
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x1

    const-string/jumbo v2, "s3:ObjectCreated:Put"

    const-string v3, "OBJECT_CREATED_PUT"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_PUT:Lio/minio/messages/EventType;

    .line 33
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x2

    const-string/jumbo v2, "s3:ObjectCreated:Post"

    const-string v3, "OBJECT_CREATED_POST"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_POST:Lio/minio/messages/EventType;

    .line 34
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x3

    const-string/jumbo v2, "s3:ObjectCreated:Copy"

    const-string v3, "OBJECT_CREATED_COPY"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_COPY:Lio/minio/messages/EventType;

    .line 35
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x4

    const-string/jumbo v2, "s3:ObjectCreated:CompleteMultipartUpload"

    const-string v3, "OBJECT_CREATED_COMPLETE_MULTIPART_UPLOAD"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_CREATED_COMPLETE_MULTIPART_UPLOAD:Lio/minio/messages/EventType;

    .line 36
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x5

    const-string/jumbo v2, "s3:ObjectAccessed:Get"

    const-string v3, "OBJECT_ACCESSED_GET"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_ACCESSED_GET:Lio/minio/messages/EventType;

    .line 37
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x6

    const-string/jumbo v2, "s3:ObjectAccessed:Head"

    const-string v3, "OBJECT_ACCESSED_HEAD"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_ACCESSED_HEAD:Lio/minio/messages/EventType;

    .line 38
    new-instance v0, Lio/minio/messages/EventType;

    const/4 v1, 0x7

    const-string/jumbo v2, "s3:ObjectAccessed:*"

    const-string v3, "OBJECT_ACCESSED_ANY"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_ACCESSED_ANY:Lio/minio/messages/EventType;

    .line 39
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0x8

    const-string/jumbo v2, "s3:ObjectRemoved:*"

    const-string v3, "OBJECT_REMOVED_ANY"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_REMOVED_ANY:Lio/minio/messages/EventType;

    .line 40
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0x9

    const-string/jumbo v2, "s3:ObjectRemoved:Delete"

    const-string v3, "OBJECT_REMOVED_DELETE"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_REMOVED_DELETE:Lio/minio/messages/EventType;

    .line 41
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0xa

    const-string/jumbo v2, "s3:ObjectRemoved:DeleteMarkerCreated"

    const-string v3, "OBJECT_REMOVED_DELETED_MARKER_CREATED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->OBJECT_REMOVED_DELETED_MARKER_CREATED:Lio/minio/messages/EventType;

    .line 42
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0xb

    const-string/jumbo v2, "s3:ReducedRedundancyLostObject"

    const-string v3, "REDUCED_REDUNDANCY_LOST_OBJECT"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->REDUCED_REDUNDANCY_LOST_OBJECT:Lio/minio/messages/EventType;

    .line 43
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0xc

    const-string/jumbo v2, "s3:BucketCreated"

    const-string v3, "BUCKET_CREATED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->BUCKET_CREATED:Lio/minio/messages/EventType;

    .line 44
    new-instance v0, Lio/minio/messages/EventType;

    const/16 v1, 0xd

    const-string/jumbo v2, "s3:BucketRemoved"

    const-string v3, "BUCKET_REMOVED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/EventType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/EventType;->BUCKET_REMOVED:Lio/minio/messages/EventType;

    .line 28
    invoke-static {}, Lio/minio/messages/EventType;->$values()[Lio/minio/messages/EventType;

    move-result-object v0

    sput-object v0, Lio/minio/messages/EventType;->$VALUES:[Lio/minio/messages/EventType;

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

    .line 48
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 49
    iput-object p3, p0, Lio/minio/messages/EventType;->value:Ljava/lang/String;

    .line 50
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/EventType;
    .locals 6
    .param p0, "eventTypeString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 59
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "s3:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 60
    .local v0, "s3EventTypeString":Ljava/lang/String;
    invoke-static {}, Lio/minio/messages/EventType;->values()[Lio/minio/messages/EventType;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v1, v3

    .line 61
    .local v4, "et":Lio/minio/messages/EventType;
    iget-object v5, v4, Lio/minio/messages/EventType;->value:Ljava/lang/String;

    invoke-virtual {p0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    iget-object v5, v4, Lio/minio/messages/EventType;->value:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_1

    .line 60
    .end local v4    # "et":Lio/minio/messages/EventType;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 62
    .restart local v4    # "et":Lio/minio/messages/EventType;
    :cond_1
    :goto_1
    return-object v4

    .line 66
    .end local v4    # "et":Lio/minio/messages/EventType;
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "unknown event \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/EventType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 28
    const-class v0, Lio/minio/messages/EventType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/EventType;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/EventType;
    .locals 1

    .line 28
    sget-object v0, Lio/minio/messages/EventType;->$VALUES:[Lio/minio/messages/EventType;

    invoke-virtual {v0}, [Lio/minio/messages/EventType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/EventType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lio/minio/messages/EventType;->value:Ljava/lang/String;

    return-object v0
.end method
