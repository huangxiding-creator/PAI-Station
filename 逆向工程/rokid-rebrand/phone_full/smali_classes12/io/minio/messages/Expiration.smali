.class public Lio/minio/messages/Expiration;
.super Lio/minio/messages/DateDays;
.source "Expiration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Expiration"
.end annotation


# instance fields
.field private expiredObjectDeleteMarker:Ljava/lang/Boolean;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ExpiredObjectDeleteMarker"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/ResponseDate;Ljava/lang/Integer;Ljava/lang/Boolean;)V
    .locals 3
    .param p1, "date"    # Lio/minio/messages/ResponseDate;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Date"
            required = false
        .end annotation
    .end param
    .param p2, "days"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Days"
            required = false
        .end annotation
    .end param
    .param p3, "expiredObjectDeleteMarker"    # Ljava/lang/Boolean;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ExpiredObjectDeleteMarker"
            required = false
        .end annotation
    .end param

    .line 36
    invoke-direct {p0}, Lio/minio/messages/DateDays;-><init>()V

    .line 37
    if-eqz p3, :cond_1

    .line 38
    if-nez p1, :cond_0

    if-nez p2, :cond_0

    goto :goto_2

    .line 39
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "ExpiredObjectDeleteMarker must not be provided along with Date and Days"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 42
    :cond_1
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_2

    move v2, v0

    goto :goto_0

    :cond_2
    move v2, v1

    :goto_0
    if-eqz p2, :cond_3

    goto :goto_1

    :cond_3
    move v0, v1

    :goto_1
    xor-int/2addr v0, v2

    if-eqz v0, :cond_4

    .line 43
    iput-object p1, p0, Lio/minio/messages/Expiration;->date:Lio/minio/messages/ResponseDate;

    .line 44
    iput-object p2, p0, Lio/minio/messages/Expiration;->days:Ljava/lang/Integer;

    .line 49
    :goto_2
    iput-object p3, p0, Lio/minio/messages/Expiration;->expiredObjectDeleteMarker:Ljava/lang/Boolean;

    .line 50
    return-void

    .line 46
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Only one of date or days must be set"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/time/ZonedDateTime;Ljava/lang/Integer;Ljava/lang/Boolean;)V
    .locals 1
    .param p1, "date"    # Ljava/time/ZonedDateTime;
    .param p2, "days"    # Ljava/lang/Integer;
    .param p3, "expiredObjectDeleteMarker"    # Ljava/lang/Boolean;

    .line 53
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Lio/minio/messages/ResponseDate;

    invoke-direct {v0, p1}, Lio/minio/messages/ResponseDate;-><init>(Ljava/time/ZonedDateTime;)V

    :goto_0
    invoke-direct {p0, v0, p2, p3}, Lio/minio/messages/Expiration;-><init>(Lio/minio/messages/ResponseDate;Ljava/lang/Integer;Ljava/lang/Boolean;)V

    .line 54
    return-void
.end method


# virtual methods
.method public expiredObjectDeleteMarker()Ljava/lang/Boolean;
    .locals 1

    .line 57
    iget-object v0, p0, Lio/minio/messages/Expiration;->expiredObjectDeleteMarker:Ljava/lang/Boolean;

    return-object v0
.end method
