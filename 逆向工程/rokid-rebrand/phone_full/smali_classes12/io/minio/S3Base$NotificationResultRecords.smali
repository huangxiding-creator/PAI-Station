.class public Lio/minio/S3Base$NotificationResultRecords;
.super Ljava/lang/Object;
.source "S3Base.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/S3Base;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xc
    name = "NotificationResultRecords"
.end annotation


# instance fields
.field mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

.field response:Lokhttp3/Response;

.field scanner:Ljava/util/Scanner;


# direct methods
.method public constructor <init>(Lokhttp3/Response;)V
    .locals 3
    .param p1, "response"    # Lokhttp3/Response;

    .line 1525
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1521
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords;->response:Lokhttp3/Response;

    .line 1522
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords;->scanner:Ljava/util/Scanner;

    .line 1523
    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 1526
    iput-object p1, p0, Lio/minio/S3Base$NotificationResultRecords;->response:Lokhttp3/Response;

    .line 1527
    new-instance v0, Ljava/util/Scanner;

    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/Scanner;-><init>(Ljava/lang/Readable;)V

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/util/Scanner;->useDelimiter(Ljava/lang/String;)Ljava/util/Scanner;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords;->scanner:Ljava/util/Scanner;

    .line 1528
    nop

    .line 1529
    invoke-static {}, Lcom/fasterxml/jackson/databind/json/JsonMapper;->builder()Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    move-result-object v0

    sget-object v1, Lcom/fasterxml/jackson/databind/DeserializationFeature;->FAIL_ON_UNKNOWN_PROPERTIES:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    .line 1530
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/DeserializationFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    sget-object v1, Lcom/fasterxml/jackson/databind/MapperFeature;->ACCEPT_CASE_INSENSITIVE_PROPERTIES:Lcom/fasterxml/jackson/databind/MapperFeature;

    .line 1531
    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/MapperFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    .line 1532
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->build()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$NotificationResultRecords;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 1533
    return-void
.end method


# virtual methods
.method public closeableIterator()Lio/minio/CloseableIterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lio/minio/CloseableIterator<",
            "Lio/minio/Result<",
            "Lio/minio/messages/NotificationRecords;",
            ">;>;"
        }
    .end annotation

    .line 1537
    new-instance v0, Lio/minio/S3Base$NotificationResultRecords$1;

    invoke-direct {v0, p0}, Lio/minio/S3Base$NotificationResultRecords$1;-><init>(Lio/minio/S3Base$NotificationResultRecords;)V

    return-object v0
.end method
