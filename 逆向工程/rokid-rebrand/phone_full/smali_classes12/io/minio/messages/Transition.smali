.class public Lio/minio/messages/Transition;
.super Lio/minio/messages/DateDays;
.source "Transition.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Transition"
.end annotation


# instance fields
.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/ResponseDate;Ljava/lang/Integer;Ljava/lang/String;)V
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
    .param p3, "storageClass"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "StorageClass"
            required = false
        .end annotation
    .end param

    .line 34
    invoke-direct {p0}, Lio/minio/messages/DateDays;-><init>()V

    .line 35
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    if-eqz p2, :cond_1

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_1
    xor-int/2addr v0, v2

    if-eqz v0, :cond_3

    .line 36
    iput-object p1, p0, Lio/minio/messages/Transition;->date:Lio/minio/messages/ResponseDate;

    .line 37
    iput-object p2, p0, Lio/minio/messages/Transition;->days:Ljava/lang/Integer;

    .line 41
    if-eqz p3, :cond_2

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 44
    iput-object p3, p0, Lio/minio/messages/Transition;->storageClass:Ljava/lang/String;

    .line 45
    return-void

    .line 42
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "StorageClass must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 39
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Only one of date or days must be set"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/time/ZonedDateTime;Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 1
    .param p1, "date"    # Ljava/time/ZonedDateTime;
    .param p2, "days"    # Ljava/lang/Integer;
    .param p3, "storageClass"    # Ljava/lang/String;

    .line 48
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Lio/minio/messages/ResponseDate;

    invoke-direct {v0, p1}, Lio/minio/messages/ResponseDate;-><init>(Ljava/time/ZonedDateTime;)V

    :goto_0
    invoke-direct {p0, v0, p2, p3}, Lio/minio/messages/Transition;-><init>(Lio/minio/messages/ResponseDate;Ljava/lang/Integer;Ljava/lang/String;)V

    .line 49
    return-void
.end method


# virtual methods
.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lio/minio/messages/Transition;->storageClass:Ljava/lang/String;

    return-object v0
.end method
