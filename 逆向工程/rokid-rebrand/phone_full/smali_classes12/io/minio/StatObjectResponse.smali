.class public Lio/minio/StatObjectResponse;
.super Lio/minio/GenericResponse;
.source "StatObjectResponse.java"


# instance fields
.field private deleteMarker:Z

.field private etag:Ljava/lang/String;

.field private lastModified:Ljava/time/ZonedDateTime;

.field private legalHold:Lio/minio/messages/LegalHold;

.field private retentionMode:Lio/minio/messages/RetentionMode;

.field private retentionRetainUntilDate:Ljava/time/ZonedDateTime;

.field private size:J

.field private userMetadata:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;

    .line 42
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    const-string v0, "ETag"

    invoke-virtual {p1, v0}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 46
    .local v0, "value":Ljava/lang/String;
    const-string v1, ""

    if-eqz v0, :cond_0

    const-string v2, "\""

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :cond_0
    iput-object v1, p0, Lio/minio/StatObjectResponse;->etag:Ljava/lang/String;

    .line 48
    const-string v1, "Content-Length"

    invoke-virtual {p1, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 49
    if-eqz v0, :cond_1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    goto :goto_0

    :cond_1
    const-wide/16 v1, -0x1

    :goto_0
    iput-wide v1, p0, Lio/minio/StatObjectResponse;->size:J

    .line 51
    nop

    .line 52
    const-string v1, "Last-Modified"

    invoke-virtual {p1, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-static {v1, v2}, Ljava/time/ZonedDateTime;->parse(Ljava/lang/CharSequence;Ljava/time/format/DateTimeFormatter;)Ljava/time/ZonedDateTime;

    move-result-object v1

    iput-object v1, p0, Lio/minio/StatObjectResponse;->lastModified:Ljava/time/ZonedDateTime;

    .line 54
    const-string/jumbo v1, "x-amz-object-lock-mode"

    invoke-virtual {p1, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 55
    const/4 v1, 0x0

    if-eqz v0, :cond_2

    invoke-static {v0}, Lio/minio/messages/RetentionMode;->valueOf(Ljava/lang/String;)Lio/minio/messages/RetentionMode;

    move-result-object v2

    goto :goto_1

    :cond_2
    move-object v2, v1

    :goto_1
    iput-object v2, p0, Lio/minio/StatObjectResponse;->retentionMode:Lio/minio/messages/RetentionMode;

    .line 57
    const-string/jumbo v2, "x-amz-object-lock-retain-until-date"

    invoke-virtual {p1, v2}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 58
    nop

    .line 59
    if-eqz v0, :cond_3

    invoke-static {v0}, Lio/minio/messages/ResponseDate;->fromString(Ljava/lang/String;)Lio/minio/messages/ResponseDate;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v1

    :cond_3
    iput-object v1, p0, Lio/minio/StatObjectResponse;->retentionRetainUntilDate:Ljava/time/ZonedDateTime;

    .line 61
    new-instance v1, Lio/minio/messages/LegalHold;

    const-string/jumbo v2, "x-amz-object-lock-legal-hold"

    invoke-virtual {p1, v2}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "ON"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    invoke-direct {v1, v2}, Lio/minio/messages/LegalHold;-><init>(Z)V

    iput-object v1, p0, Lio/minio/StatObjectResponse;->legalHold:Lio/minio/messages/LegalHold;

    .line 63
    const-string/jumbo v1, "x-amz-delete-marker"

    invoke-virtual {p1, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/StatObjectResponse;->deleteMarker:Z

    .line 65
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 66
    .local v1, "userMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lokhttp3/Headers;->names()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 67
    .local v3, "key":Ljava/lang/String;
    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    const-string/jumbo v5, "x-amz-meta-"

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 68
    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 69
    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 70
    invoke-virtual {p1, v3}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 68
    invoke-interface {v1, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 72
    .end local v3    # "key":Ljava/lang/String;
    :cond_4
    goto :goto_2

    .line 74
    :cond_5
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v2

    iput-object v2, p0, Lio/minio/StatObjectResponse;->userMetadata:Ljava/util/Map;

    .line 75
    return-void
.end method


# virtual methods
.method public contentType()Ljava/lang/String;
    .locals 2

    .line 110
    invoke-virtual {p0}, Lio/minio/StatObjectResponse;->headers()Lokhttp3/Headers;

    move-result-object v0

    const-string v1, "Content-Type"

    invoke-virtual {v0, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public deleteMarker()Z
    .locals 1

    .line 102
    iget-boolean v0, p0, Lio/minio/StatObjectResponse;->deleteMarker:Z

    return v0
.end method

.method public etag()Ljava/lang/String;
    .locals 1

    .line 78
    iget-object v0, p0, Lio/minio/StatObjectResponse;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public lastModified()Ljava/time/ZonedDateTime;
    .locals 1

    .line 86
    iget-object v0, p0, Lio/minio/StatObjectResponse;->lastModified:Ljava/time/ZonedDateTime;

    return-object v0
.end method

.method public legalHold()Lio/minio/messages/LegalHold;
    .locals 1

    .line 98
    iget-object v0, p0, Lio/minio/StatObjectResponse;->legalHold:Lio/minio/messages/LegalHold;

    return-object v0
.end method

.method public retentionMode()Lio/minio/messages/RetentionMode;
    .locals 1

    .line 90
    iget-object v0, p0, Lio/minio/StatObjectResponse;->retentionMode:Lio/minio/messages/RetentionMode;

    return-object v0
.end method

.method public retentionRetainUntilDate()Ljava/time/ZonedDateTime;
    .locals 1

    .line 94
    iget-object v0, p0, Lio/minio/StatObjectResponse;->retentionRetainUntilDate:Ljava/time/ZonedDateTime;

    return-object v0
.end method

.method public size()J
    .locals 2

    .line 82
    iget-wide v0, p0, Lio/minio/StatObjectResponse;->size:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 119
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ObjectStat{bucket="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 121
    invoke-virtual {p0}, Lio/minio/StatObjectResponse;->bucket()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", object="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 123
    invoke-virtual {p0}, Lio/minio/StatObjectResponse;->object()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", last-modified="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/StatObjectResponse;->lastModified:Ljava/time/ZonedDateTime;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", size="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lio/minio/StatObjectResponse;->size:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 119
    return-object v0
.end method

.method public userMetadata()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 114
    iget-object v0, p0, Lio/minio/StatObjectResponse;->userMetadata:Ljava/util/Map;

    return-object v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 2

    .line 106
    invoke-virtual {p0}, Lio/minio/StatObjectResponse;->headers()Lokhttp3/Headers;

    move-result-object v0

    const-string/jumbo v1, "x-amz-version-id"

    invoke-virtual {v0, v1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
