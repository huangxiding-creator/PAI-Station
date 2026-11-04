.class final Lcom/amazonaws/util/TimingInfoUnmodifiable;
.super Lcom/amazonaws/util/TimingInfo;
.source "TimingInfoUnmodifiable.java"


# direct methods
.method constructor <init>(Ljava/lang/Long;JLjava/lang/Long;)V
    .locals 0
    .param p1, "startEpochTimeMilli"    # Ljava/lang/Long;
    .param p2, "startTimeNano"    # J
    .param p4, "endTimeNano"    # Ljava/lang/Long;

    .line 32
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/amazonaws/util/TimingInfo;-><init>(Ljava/lang/Long;JLjava/lang/Long;)V

    .line 33
    return-void
.end method


# virtual methods
.method public endTiming()Lcom/amazonaws/util/TimingInfo;
    .locals 1

    .line 53
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public setEndTime(J)V
    .locals 1
    .param p1, "endTime"    # J

    .line 37
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public setEndTimeNano(J)V
    .locals 1
    .param p1, "endTimeNano"    # J

    .line 45
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
