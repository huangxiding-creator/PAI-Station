.class public abstract Lio/minio/messages/DateDays;
.super Ljava/lang/Object;
.source "DateDays.java"


# instance fields
.field protected date:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Date"
        required = false
    .end annotation
.end field

.field protected days:Ljava/lang/Integer;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Days"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public date()Ljava/time/ZonedDateTime;
    .locals 1

    .line 32
    iget-object v0, p0, Lio/minio/messages/DateDays;->date:Lio/minio/messages/ResponseDate;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/messages/DateDays;->date:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public days()Ljava/lang/Integer;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/DateDays;->days:Ljava/lang/Integer;

    return-object v0
.end method
